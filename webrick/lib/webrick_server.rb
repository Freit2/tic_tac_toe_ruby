require 'webrick'

class WEBrickServer
  attr_reader :server, :port, :document_root

  def initialize(port=10000+rand(10000))
    @port ||= port
    WEBrick::HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html')
    @server = WEBrick::HTTPServer.new({:Port => @port, :DocumentRoot => @document_root})
  end

  def mount(dir, servlet, *options)
    @server.mount dir, servlet, *options
  end

  def search_servlet(path)
    @server.search_servlet(path)
  end

  def start
    puts "=> Server started at http://localhost:#{@port}..."
    trap "INT" do shutdown end
    @server.start
  end

  def shutdown
    @server.shutdown
  end
end
