$: << File.expand_path(File.dirname(__FILE__) + "/../lib")
require 'ttt'
require 'webrick_server'
require 'webrick_options_servlet'
require 'webrick_board_servlet'

class WEBrickTTT
  include TTT

  attr_reader :server

  def initialize(port=10000+rand(10000))
    load_libraries
    initialize_cache
    @server = WEBrickServer.new(port)
    @server.mount("/", OptionsServlet)
    @server.mount("/new", BoardServlet, @cache)
  end

  def start
    @server.start
  end
end

if $0 == __FILE__ then
  WEBrickTTT.new(7546).start
end
