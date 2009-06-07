$KCODE = 'SJIS'

require 'lib/ponitool'

module PoniChannel
	PONICHANNEL_VERSION = '0.0.1'
end

class Time
	def to_s
		self.strftime('%Y/%m/%d(%a) %H:%M:%S')
	end
end

module PoniChannel
	class BBS
		def initialize(script, ita)
			@cfg = {}
			@cfg['ita'] = ita
			@cfg['itadir'] = "data/bbs/#{ita}"
		end

		def run(req, res, ispost)
#p req.request_uri
#p req.header
			do_write(req, res) if ispost

		end

def cfg
	@cfg
end
	end

	class BBS
		private

CHARSET = {'NONE' => '', 'EUC' => "; charset=euc-jp", 'SJIS' => "; charset=shift-jis", 'UTF8' => "; charset=utf-8"}

def contentconfig(session, param, page = nil)
	session.res['Content-Type'] = "text/html#{CHARSET[$KCODE]}"

	param['header'] = "\t<meta http-equiv=\"Content-Type\" content=\"text/html#{CHARSET[$KCODE]}\" />\n" +
	"\t<meta http-equiv=\"Content-Language\" content=\"ja\" />\n" +
	"\t<meta name=\"generator\" content=\"PoniChanell #{PONICHANNEL_VERSION}\" />\n" +
	"\t<meta http-equiv=\"content-style-type\" content=\"text/css\" />\n" +
	"\t<link media=\"all\" href=\"#{@cfg['themepath']}/#{@cfg['theme']}/#{@cfg['theme']}.css\" type=\"text/css\" rel=\"stylesheet\" />\n"

	param['encode'] = CHARSET[$KCODE]

	param['poniver'] = PONICHANNEL_VERSION
	param['rubyver'] = RUBY_VERSION

	param['script'] = @cfg['script']

	param['user'] = session.anonymous? ? nil : session.user
end

		def do_start(session)
			do_view(session)
		end

		def do_view(session)
			t = Time.now

			template = PoniTool::Template.new
			template.param['content'] = content
			session.res.body = template.output

		end

#		def dat_write(from, mail, message, 

		# newkey 取得関数に変更
		def bbs_lock(key)
			lockpath = "#{@cfg['itadir']}/#{key}.lock"
			begin
				Dir.mkdir(lockpath)
				begin
					yield
				ensure
					Dir.rmdir(lockpath)
				end
			rescue Errno::EEXIST
				raise Error
			end
		end

		def message_escape(message)
			message.escape
		end

		def do_write(req, res)
#print "#{req.query['MESSAGE']}\n" # 書き込み本文
#print "#{req.query['time']}\n"    # dat key
#print "#{req.query['submit']}\n"  # submit ラベル
#print "#{req.query['FROM']}\n"    # 名前
#print "#{req.query['mail']}\n"    # mail
#print "#{req.query['subject']}\n" # スレ立て時のタイトル
#print "#{req.query['bbs']}\n"     # bbs名
#print "#{req.query['key']}\n"     # 書き込み時のdat key

			#user = req.query['FROM']
			user = 'Nameless Cult'

			if req.query['submit'] == "新規スレッド作成"
				# key ga tadasii ka douka no kakunin
				# subject lock

				File.open("#{@cfg['itadir']}/subject.txt", "a") { |f|
					f << "#{req.query['time']}<>#{req.query['subject']} (1)\n"
				}

				File.open("#{@cfg['itadir']}/dat/#{req.query['time']}.dat", "w") { |f|
					f << "#{user}<>#{req.query['mail']}<>#{Time.now.strftime('%Y/%m/%d(%a) %H:%M:%S')}<> #{message_escape(req.query['MESSAGE'])} <>#{req.query['subject']}\n"
				}

			elsif req.query['submit'] == "書き込む"
				# subject lock
				list = ""
				File.open("#{@cfg['itadir']}/subject.txt", "r") { |f|
					f.each { |line|
						key, = line.split('<>')
						if key != req.query['key']
							list << line
						else
							line.gsub!(/\(\d*\)/) { |s| s.succ}
							if req.query['mail'].match(/.*[Ss][Aa][Gg][Ee].*/) == nil
								list.insert(0, line)
							else
								list << line
							end
						end
					}
				}

				File.open("#{@cfg['itadir']}/subject.txt", "w") { |f|
					f << list
				}

				File.open("#{@cfg['itadir']}/dat/#{req.query['key']}.dat", "a") { |f|
					f << "#{user}<>#{req.query['mail']}<>#{Time.now.strftime('%Y/%m/%d(%a) %H:%M:%S')}<> #{message_escape(req.query['MESSAGE'])} \n"
				}

			else
				res['Content-Type'] = "text/html#{CHARSET[$KCODE]}"
				res.body = "謎のコマンド"
printt "謎のコマンド\n"
				return

			end

			res['Content-Type'] = "text/html#{CHARSET[$KCODE]}"
			res.body = "<html><head><title>書きこみました。</title><!--nobanner--><meta http-equiv=\"Content-Type\" content=\"text/html; charset=Shift_JIS\"><meta content=5;URL=../test/ http-equiv=refresh></head><body>書きこみが終わりました。<br><br>画面を切り替えるまでしばらくお待ち下さい。<br><br><br><br><br><hr></body></html>"
		end

	end
end


