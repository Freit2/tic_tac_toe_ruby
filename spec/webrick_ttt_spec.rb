require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'webrick_ttt'

describe WEBrickTTT do
  it "should include TTT" do
    WEBrickTTT.should include(TTT)
  end

  it "should create an instance of WEBrickServer" do
    webrick_ttt = WEBrickTTT.new
    webrick_ttt.server.class.should == WEBrickServer
  end

end