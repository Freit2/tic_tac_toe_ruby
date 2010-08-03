$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require 'ttt'
require 'webrick_server'
require 'webrick_options_servlet'
require 'webrick_board_servlet'

class WEBrickTTT
  include TTT

  def initialize
    load_libraries
    initialize_cache
    webrick_server = WEBrickServer.new(7546)
    webrick_server.mount("/", OptionsServlet)
    webrick_server.mount("/new", BoardServlet)
    webrick_server.start
  end
end

if $0 == __FILE__ then
  WEBrickTTT.new
end
