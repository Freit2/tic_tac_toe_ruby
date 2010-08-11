require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'webrick_ttt'

describe WEBrickTTT do
  before(:all) do
    @webrick_ttt = WEBrickTTT.new
  end

  it "should include TTT" do
    WEBrickTTT.should include(TTT)
  end

  it "should set defaults" do
    @webrick_ttt.port.should_not == nil
    @webrick_ttt.document_root.should_not == nil
    @webrick_ttt.rhtml_path.should_not == nil
    @webrick_ttt.board_selection.should_not == nil
    @webrick_ttt.player_selection_o.should_not == nil
    @webrick_ttt.player_selection_x.should_not == nil
  end

  it "should create an instance of WEBrickServer" do
    @webrick_ttt.server.class.should == WEBrick::HTTPServer
  end

  it "should mount servlet" do
    @webrick_ttt.server.search_servlet("/new")[0].should == BoardServlet
  end

  it "should receive message on start" do
    @webrick_ttt.should_receive(:generate_index)
    @webrick_ttt.server.should_receive(:start)
    @webrick_ttt.start
  end
  
  it "should generate index" do
    if File.exists?("#{File.dirname(__FILE__)}/../lib/www/index.html")
      File.delete("#{File.dirname(__FILE__)}/../lib/www/index.html")
    end
    @webrick_ttt.generate_index

    File.exists?("#{File.dirname(__FILE__)}/../lib/www/index.html")
  end

  it "should generate options for board" do
    html = @webrick_ttt.options_for_board
    html.include?("<option selected=\"selected\">#{@webrick_ttt.board_selection}</option>").should == true
    html.include?("4x4").should == true
  end

  it "should generate options for players" do
    html = @webrick_ttt.options_for_player(@webrick_ttt.player_selection_o)
    html.include?("<option selected=\"selected\">#{@webrick_ttt.player_selection_o}</option>")
  end
end
