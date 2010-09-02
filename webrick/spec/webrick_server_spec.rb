require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'webrick_server'

describe WEBrickServer do
  before(:each) do
    @port = 10000+rand(10000)
  end

  it "should start an instance of WEBrick::HTTPServer with the correct port" do
    webrick_server = WEBrickServer.new(@port)
    webrick_server.server.class.should == WEBrick::HTTPServer
    webrick_server.port.should == @port
    webrick_server.server.config[:Port].should == @port
  end

  it "should not start WEBrick::HTTPServer on initialize" do
    webrick_server = WEBrickServer.new(@port)
    webrick_server.server.status.should == :Stop
  end

  it "should start WEBrick::HTTPServer when explicitly told to" do
    webrick_server = WEBrickServer.new(@port)
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
