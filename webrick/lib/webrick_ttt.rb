require File.expand_path(File.dirname(__FILE__)) + "/init"
require 'webrick_server'
require 'options_servlet'
require 'board_servlet'

class WEBrickTTT
  include TTT

  attr_reader :server

  def initialize(port=10000+rand(10000))
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
