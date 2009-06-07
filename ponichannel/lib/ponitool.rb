require 'lib/escape'

class String
	ESC = {
		'&' => '&amp;',
		'"' => '&quot;',
		'<' => '&lt;',
		'>' => '&gt;',
		"\r" => '',
		"\n" => ' <br> ',
	}

	def escape
		table = ESC   # optimize
		self.gsub(/[&"<>\r\n]/n) {|s| table[s] }
	end

	def escapeurl
		Web::escape(self)
		#URI.escape(self)
	end

	def unescapeurl
		Web::unescape(self)
		#URI.unescape(self)
	end

	def escape!
		table = ESC   # optimize
		self.gsub!(/[&"<>\r\n]/n) {|s| table[s] }
	end
end

module PoniTool
	def self.indent(level)
		str = ''
		for i in 0 .. level - 1
			str << ' '
		end
		str
	end

	class Template
		def initialize(src = nil)
			@src = src
			@tree = RootNode.new
			@param = {}
			@plugin = {}
			parse if @src != nil
		end

		def load(filename)
			@filename = filename
			open(filename) { |f|
				@src = f.read
			}
			parse
		end

		def parse
			esc = nil
			tree = @tree
			lines = 1

			@src.each { |line|
				if esc != nil
					pos = line.index(esc)
					if pos == nil
						tree.textadd(@filename, lines, line)
						lines += 1 if /\n/ =~ line
						next
					else
						tree.textadd(@filename, lines, line[0 .. pos - 1]) if pos > 0
						pos += esc.length
						line = line[pos .. line.length - 1]
						esc = nil
						redo
					end
				end

				#if /\{\{([^\s\{\}]+)\s*([^\s\{\}]*)\}\}/ =~ line
				if /\{\{([^\s\{\}]+)\s*([^\{\}]*)\}\}/ =~ line
					tree.textadd(@filename, lines, $`) if $` != ""
					line = $'
					opt = $2.split

					case $1.downcase
					when '@if'
						ifnode = IfNode.new(@filename, lines, opt[0], tree)
						tree << ifnode
						tree = ifnode

					when '@else'
						ifnode = IfNode.new(@filename, lines, tree.elsevalue, tree.parentnode)
						tree.parentnode << ifnode
						tree = ifnode

					when '@loop'
						loopnode = LoopNode.new(@filename, lines, opt[0], tree)
						tree << loopnode
						tree = loopnode

					# XXX plugin
					when '@db'
						dbnode = DBNode.new(self, @filename, lines, opt[0], tree, opt[1])
						tree << dbnode
						tree = dbnode

					when '@end'
						tree = tree.parentnode

#						if tree == nil
# error 処理(lines, @filename)
					when '@escape'
						esc = opt[0]

					else
						if $1[0] == '#'[0] && @plugin[$1.downcase[1 .. -1]] != nil
							tree << TextNode.new(@filename, lines, @plugin[$1.downcase[1 .. -1]].ontemplate(opt))
						else
							case (opt[0] || '').downcase
							when 'url'
								tree << VarNode.new(@filename, lines, $1, :ESCAPEURL)
							when 'html'
								tree << VarNode.new(@filename, lines, $1, :ESCAPEHTML)
							when 'text'
								tree << VarNode.new(@filename, lines, $1, :TEXT)
							else
								tree << VarNode.new(@filename, lines, $1)
							end
						end
					end
					redo if line != ""
				else
					tree.textadd(@filename, lines, line)
					lines += 1 if /\n/ =~ line
				end
			}
		end

		def param
			@param
		end

		def param=(newparam)
			newparam.each { |name, val|
				@param[name] = val
			}
		end

		def tree
			@tree
		end

		def output(param = nil)
			@param = param if (param != nil)
			@tree.output(@param)
		end

		def each(&block)
			@tree.each(&block)
		end

		def db=(db)
			@db = db
		end

		def db
			@db
		end

		def pluginadd(name, plugin)
			@plugin[name.downcase] = plugin
		end

		class Node
			def initialize(filename, lines, value)
				@filename = filename
				@lines = lines
				@value = value
			end

			def var(param)
				param[@value]
#print "#{@value}: #{loopparam.inspect}\n"
			end
		end

		class TextNode < Node
			def output(param)
				@value
			end

			def tree_inspect(level)
				"#{PoniTool::indent(level)}#{@value.inspect}\n"
			end

			def textadd(text)
				@value << text
			end

			def each(&block)
				block.call(self)
			end

			def name
				@value
			end
		end

		class VarNode < Node
			def initialize(filename, lines, value, *options)
				@type = :STR

				super(filename, lines, value)
				options.each { |opt|
					case opt
					when :ESCAPEHTML
						@escape = :ESCAPEHTML
					when :ESCAPEURL
						@escape = :ESCAPEURL

					when :TEXT
						@type = :TEXT
					end
				}
			end

			def output(param)
				if var(param) == nil
					STDERR << "#{@value} not found.\n" 
					return ""
				end

				case @escape
				when :ESCAPEHTML
					var(param).to_s.escape

				when :ESCAPEURL
					var(param).to_s.escapeurl

				else
					var(param).to_s
				end
			end
			def tree_inspect(level)
				"#{PoniTool::indent(level)}@var #{@value}\n"
			end

			def name
				@value
			end

			def type
				@type
			end

			def each(&block)
				block.call(self)
			end

		end

		class ParentNode < Node
			def <<(node)
				@child << node
			end

			def parentnode
				@parentnode
			end

			def textadd(filename, lines, text)
				if @child.length > 0 && @child[@child.length - 1].kind_of?(TextNode)
					@child[@child.length - 1].textadd(text)
				else
					@child << TextNode.new(filename, lines, text)
				end
			end

			def each(&block)
				block.call(self)
				@child.each { |node|
					node.each(&block)
				}

				block.call(nil)
			end

		end

		class RootNode < ParentNode
			def initialize
				@child = []
			end

			def output(param)
				content = ''
				@child.each { |node|
					content << node.output(param)
				}
				content
			end

			def inspect
				level = 2
				str = "[\n"
				@child.each { |node|
					str << node.tree_inspect(level)
				}

				str + "]\n"
			end

		end

		class IfNode < ParentNode
			def initialize(filename, lines, value, parentnode)
				@child = []
				if value[0] != '!'[0]
					@unless = false
				else
					@unless = true
					value = value[1 .. value.length - 1]
				end
				@parentnode = parentnode

				super(filename, lines, value)
			end

			def elsevalue
				if @unless
					@value
				else
					"!#{@value}"
				end
			end

			def output(param)
				content = ''
# XXX 変数が '' の時も false にしているが、問題があるかもしれない。
				if (!@unless && var(param) && var(param) != '' ) || 
				    (@unless && (!var(param) || var(param) == ''))
					@child.each { |node|
						content << node.output(param)
					}
				end
				content
			end
			def tree_inspect(level)
				str = "#{PoniTool::indent(level)}@if "
				str << "!" if @unless
				str << "#{@value}\n"
				str << "#{PoniTool::indent(level)}[\n"
				@child.each { |node|
					str << node.tree_inspect(level + 2)
				}
				str + "#{PoniTool::indent(level)}]\n"
			end
		end

		class LoopNode < ParentNode
			def initialize(filename, lines, value, parentnode)
				@child = []
				@parentnode = parentnode

				super(filename, lines, value)
			end

			def output(param)
STDERR << "#{@filename}:#{@lines} #{@value} is not found.\n" if var(param) == nil

				content = ''
				var(param).each { |loopparam|
					newparam = param.dup
					loopparam.each { |name, val|
						newparam[name] = val
					}

					@child.each { |node|
						content << node.output(newparam)
					}
				}
				content
			end
			def tree_inspect(level)
				str = "#{PoniTool.indent(level)}@loop #{@value}\n"
				str << "#{PoniTool.indent(level)}[\n"
				@child.each { |node|
					str << node.tree_inspect(level + 2)
				}
				str + "#{PoniTool.indent(level)}]\n"
			end

			def name
				@value
			end
		end

		class DBNode < ParentNode
			def initialize(template, filename, lines, value, parentnode, query)
				@child = []
				@parentnode = parentnode
				@query = query
				@template = template

				super(filename, lines, value)
			end

			def output(param)
STDERR << "#{@filename}:#{@lines} #{@value} is not found.\n" if var(param) == nil

				data = @template.db.open(@value).query(@query)

				content = ''
				data.each { |loopparam|
					newparam = param.dup
					loopparam.each { |name, val|
						newparam["#{@value}.#{name}"] = val
					}
					@child.each { |node|
						content << node.output(newparam)
					}
				}
				content
			end
			def tree_inspect(level)
				str = "#{PoniTool.indent(level)}@db #{@value}\n"
				str << "#{PoniTool.indent(level)}[\n"
				@child.each { |node|
					str << node.tree_inspect(level + 2)
				}
				str + "#{PoniTool.indent(level)}]\n"
			end
		end
	end
end
