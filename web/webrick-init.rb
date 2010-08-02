require 'webrick'
require 'webrick-get'
require 'webrick-post'

if $0 == __FILE__ then
  server = WEBrick::HTTPServer.new(:Port => 7546)
  server.mount "/", Options
  server.mount "/new", Board
  trap "INT" do server.shutdown end
  server.start
end
