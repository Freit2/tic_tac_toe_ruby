require 'webrick'

class WEBrickServer
  attr_reader :server, :port

  def initialize(port=10000+rand(10000), document_root=nil)
    WEBrick::HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html')
    @port = port
    @document_root = document_root
    @server = WEBrick::HTTPServer.new(:Port => port, :DocumentRoot => @document_root)
  end

  def mount(dir, servlet, *options)
    @server.mount dir, servlet, *options
  end

  def search_servlet(path)
    @server.search_servlet(path)
  end

  def start
    trap "INT" do shutdown end
    @server.start
  end

  def shutdown
    @server.shutdown
  end
end
