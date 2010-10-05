require 'spec_helper'

describe TicTacToeHelper do
  before(:each) do
    @ttt = TicTacToe.new
    @ttt.request = {:board => '3x3',
                    :player_o => 'human',
                    :player_x => 'unbeatable'}
  end

  before(:all) do
    TicTacToeEngine::TTT::CONFIG.boards[:'3x3'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards[:'4x4'][:active] = true
    include TicTacToeHelper
  end

  it "returns options for board" do
    options_for_board.should == "<option selected=\"selected\">3x3</option><option>4x4</option>"
  end

  it "returns options for player" do
    options_for_player(TicTacToeEngine::TTT::CONFIG[:players][TicTacToeEngine::TTT::CONFIG[:players].keys.first][:value]).should ==
      "<option selected=\"selected\">human</option><option>easy</option><option>med</option><option>unbeatable</option>"

    options_for_player(TicTacToeEngine::TTT::CONFIG[:players][TicTacToeEngine::TTT::CONFIG[:players].keys.last][:value]).should ==
      "<option>human</option><option>easy</option><option>med</option><option selected=\"selected\">unbeatable</option>"
  end

  it "returns quit html" do
    generate_quit_html.should ==
      "<form method='GET' action='/'>" +
      "<input type=\"submit\" value=\"Return to Options\" />" +
      "</form>"
  end

  it "returns status html" do
    generate_status_html.should == ""
    @ttt.status = "hello world"
    generate_status_html.should == "<img src=\"#{@ttt.status}\" alt=\"status\" width=\"502\" height=\"75\"/>"
  end

  it "returns try again html" do
    @ttt.create_board
    @ttt.board.should_receive(:game_over?).and_return(false)
    generate_try_again_html.should == ""
    @ttt.board.should_receive(:game_over?).and_return(true)
    generate_try_again_html.should == "<form method='POST' action='/game/start'>" +
            "<input type=\"hidden\" name=\"board\" value=\"#{@ttt.request[:board]}\">" +
            "<input type=\"hidden\" name=\"player_o\" value=\"#{@ttt.request[:player_o]}\">" +
            "<input type=\"hidden\" name=\"player_x\" value=\"#{@ttt.request[:player_x]}\">" +
            "<img src=\"/images/labels/try_again.png\">" +
            "<input type=\"submit\" value=\"Yes\" />" +
            "</form>"
  end

  it "returns square html" do
    @ttt.create_board
    generate_square_html(0).should ==
      "<a href=\"/game/start?s=0\"><img border=\"1\" " +
      "src=\"/images/pieces/empty_square.png\" alt=\"square\" " +
      "width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" " +
      "onmouseout=\"TTT.mouseOutSquare(this)\"/></a>"
  end

  it "returns board html" do
    @ttt.create_board
    generate_board_html.should ==
    "<a href=\"/game/start?s=0\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" alt=\"square\" width=\"130\" height=\"130\" " +
    "onmouseover=\"TTT.mouseOverSquare(this)\" onmouseout=\"TTT.mouseOutSquare(this)\"/></a><a href=\"/game/start?s=1\"><img border=\"1\" " +
    "src=\"/images/pieces/empty_square.png\" alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" " +
    "onmouseout=\"TTT.mouseOutSquare(this)\"/></a><a href=\"/game/start?s=2\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" " +
    "alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" onmouseout=\"TTT.mouseOutSquare(this)\"/></a><br />" +
    "<a href=\"/game/start?s=3\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" alt=\"square\" width=\"130\" height=\"130\" " +
    "onmouseover=\"TTT.mouseOverSquare(this)\" onmouseout=\"TTT.mouseOutSquare(this)\"/></a><a href=\"/game/start?s=4\"><img border=\"1\" " +
    "src=\"/images/pieces/empty_square.png\" alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" " +
    "onmouseout=\"TTT.mouseOutSquare(this)\"/></a><a href=\"/game/start?s=5\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" " +
    "alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" onmouseout=\"TTT.mouseOutSquare(this)\"/></a><br />" +
    "<a href=\"/game/start?s=6\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" alt=\"square\" width=\"130\" height=\"130\" " +
    "onmouseover=\"TTT.mouseOverSquare(this)\" onmouseout=\"TTT.mouseOutSquare(this)\"/></a><a href=\"/game/start?s=7\"><img border=\"1\" " +
    "src=\"/images/pieces/empty_square.png\" alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" " +
    "onmouseout=\"TTT.mouseOutSquare(this)\"/></a><a href=\"/game/start?s=8\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" " +
    "alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" onmouseout=\"TTT.mouseOutSquare(this)\"/></a><br />"
  end
end
