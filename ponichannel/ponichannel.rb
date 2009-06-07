if FileTest::symlink?(__FILE__)
	path = File.expand_path(File::dirname(File::readlink(__FILE__)))
else
	path = File.expand_path(File::dirname(__FILE__))
end
$:.unshift(path)

require 'ponichannel_main'
