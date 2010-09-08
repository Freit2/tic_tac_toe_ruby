require 'webrick'

class WEBrickServer
  attr_reader :server, :port

  def initialize(port)
    @port ||= port
    WEBrick::HTTPUtils::DefaultMimeTypes.store('rhtml', 'text/html')
    @server = WEBrick::HTTPServer.new({:Port => @port})
  end

  def mount(dir, servlet, *options)
    @server.mount dir, servlet, *options
  end

  def mount_proc(dir, proc=nil, &block)
    @server.mount_proc(dir, proc, &block)
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
