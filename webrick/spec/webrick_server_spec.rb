require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'webrick_server'

describe WEBrickServer do
  it "should start an instance of WEBrick::HTTPServer" do
    webrick_server = WEBrickServer.new
    webrick_server.server.class.should == WEBrick::HTTPServer
  end

  it "should start an instance of WEBrick::HTTPServer with the correct port" do
    port = 1234
    webrick_server = WEBrickServer.new(port)
    webrick_server.port.should == port
    webrick_server.server.config[:Port].should == port
  end

  it "should not start WEBrick::HTTPServer on initialize" do
    webrick_server = WEBrickServer.new
    webrick_server.server.status.should == :Stop
  end

  it "should start WEBrick::HTTPServer when explicitly told to" do
    webrick_server = WEBrickServer.new
    thread = Thread.new { webrick_server.start }
    loop do
      sleep 0.5
      break if webrick_server.server.status != :Stop
    end
    webrick_server.server.status.should == :Running
    webrick_server.shutdown
    thread.join
  end
end
