module YAMLOUT
	def self.yamlout(v)
		"---\n#{conv(v)}"
	end

	def self.spcindent(level)
		str = ''
		for i in 0 .. level - 1
			str << ' '
		end
		str
	end

	ESCAPES = %w{\x00   \x01	\x02	\x03	\x04	\x05	\x06	\a
			     \x08	\t		\n		\v		\f		\r		\x0e	\x0f
				 \x10	\x11	\x12	\x13	\x14	\x15	\x16	\x17
				 \x18	\x19	\x1a	\e		\x1c	\x1d	\x1e	\x1f
			    }

	def self.strout(s)
		s.gsub(/\\/, "\\\\\\").gsub(/"/, "\\\"").gsub(/([\x00-\x1f])/) { |x|
			ESCAPES[x.unpack("C")[0]]
		}
	end

	def self.conv(v, indent = -2)
		outstr = ''
		if v.kind_of?(Hash)
			indent += 2

			v.each { |key, val|
				outstr << "#{spcindent(indent)}\"#{strout(key)}\": "
				if val.kind_of?(String)
					outstr << "\"#{strout(val)}\"\n"
				else
					outstr << "\n#{conv(val, indent)}"
				end
			}

		elsif v.kind_of?(Array)
			indent += 2

			for i in 0 .. v.length - 1
				outstr << "#{spcindent(indent)}- "
				if v[i].kind_of?(String)
					outstr << "\"#{strout(v[i])}\"\n"
				else
					outstr << "\n#{conv(v[i], indent)}"
				end
			end

		elsif v.kind_of?(String)
			outstr << "\"#{strout(v)}\"\n"

		else
			STDERR << v.inspect
			raise
		end

		outstr
	end
end
