require 'webrick'

module PoniChannel
	class BBSServlet < WEBrick::HTTPServlet::AbstractServlet
		def initialize(server, opt)
			super
			@bbs = opt
		end

		def do_GET(req, res)
			@bbs.run(req, res, false)
		end

		def do_POST(req, res)
			@bbs.run(req, res, true)
		end
	end

	def self.webrick(opt)
		s = WEBrick::HTTPServer.new(opt)

		bbs = PoniChannel::BBS.new('ponichannel.cgi', 'test')

		if bbs.cfg['debug']
			require 'lib/autoreload'
			AutoReload.start(1, true)
		end

		#s.mount("#{bbs.cfg['themepath']}/", WEBrick::HTTPServlet::FileHandler, bbs.cfg['themedir'])
		s.mount('/', PoniChannel::BBSServlet, bbs)

		s.mount("/test/", WEBrick::HTTPServlet::FileHandler, "data/bbs/test/")
		#s.mount("/test/subject.txt", WEBrick::HTTPServlet::FileHandler, "data/bbs/test/subject.txt")
		s.mount("/test/bbs.cgi", PoniChannel::BBSServlet, bbs)

		trap('INT') {
			s.shutdown
		}

		s.start
	end

end

