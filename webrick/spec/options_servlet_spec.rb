require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'options_servlet'
include TTT

describe OptionsServlet do
  before(:each) do
    @server = mock("WEBrick::HTTPServer")
    @server.should_receive(:[])
    initialize_cache
    @option_servlet = OptionsServlet.new(@server, TTT::CONFIG.cache)
    @option_servlet.board_selection = '3x3'
    @option_servlet.player_selection_o = 'human'
    @option_servlet.player_selection_x = 'unbeatable'
    TTT::CONFIG.boards['3x3'][:active] = true
    TTT::CONFIG.boards['4x4'][:active] = true
  end

  it "should have default for board selection" do
    @server.should_receive(:[])
    option_servlet = OptionsServlet.new(@server, TTT::CONFIG.cache)
    option_servlet.board_selection.should_not == nil
    option_servlet.board_selection.should_not == ""
  end
  
  it "should have default for player_selections" do
    @server.should_receive(:[])
    option_servlet = OptionsServlet.new(@server, TTT::CONFIG.cache)
    option_servlet.player_selection_o.should_not == nil
    option_servlet.player_selection_o.should_not == ""
    option_servlet.player_selection_x.should_not == nil
    option_servlet.player_selection_x.should_not == ""
  end

  it "should contain cache hash" do
    @option_servlet.options.class.should == TTT::Config
    @option_servlet.options.keys.size.should > 0
  end

  it "should return all boards in tags" do
    @option_servlet.options_for_board.should == "<option selected=\"selected\">3x3</option>" +
      "<option>4x4</option>"
  end

  it "should select default board option" do
    @option_servlet.board_selection = "4x4"
    @option_servlet.options_for_board.should == "<option>3x3</option>" +
      "<option selected=\"selected\">4x4</option>"
  end

  it "should return only active boards" do
    TTT::CONFIG.boards['4x4'][:active] = false
    @option_servlet.options_for_board.should == "<option selected=\"selected\">3x3</option>"
  end

  it "should return all players in tags" do
    @option_servlet.options_for_player(@option_servlet.player_selection_o).should ==
      "<option selected=\"selected\">human</option><option>easy</option>" +
      "<option>med</option><option>unbeatable</option>"
  end

  it "should return default player option" do
    @option_servlet.player_selection_o = "easy"
    @option_servlet.player_selection_x = "med"
    @option_servlet.options_for_player(@option_servlet.player_selection_o).should ==
      "<option>human</option><option selected=\"selected\">easy</option>" +
      "<option>med</option><option>unbeatable</option>"
    @option_servlet.options_for_player(@option_servlet.player_selection_x).should ==
      "<option>human</option><option>easy</option>" +
      "<option selected=\"selected\">med</option><option>unbeatable</option>"
  end

  it "should return erb object" do
    IO.should_receive(:read).and_return("this is a string")
    @option_servlet.erbize("some_erb.file").class.should == ERB
  end

  it "should return status, content_type, body" do
    @option_servlet.should_receive(:erbize).and_return(template = mock("ERB"))
    template.should_receive(:result).and_return(template_value = mock("result_of_template"))
    @option_servlet.display_options(nil).should == [200, "text/html", template_value]
  end
end
