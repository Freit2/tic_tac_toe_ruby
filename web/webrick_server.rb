require 'webrick'

class WEBrickServer
  attr_reader :server, :port

  def initialize(port=10000+rand(10000))
    @port = port
    @server = WEBrick::HTTPServer.new(:Port => port)
  end

  def mount(path, class_name, *options)
    @server.mount path, class_name, *options
  end

  def start
    trap "INT" do shutdown end
    @server.start
  end

  def shutdown
    @server.shutdown
  end
end
