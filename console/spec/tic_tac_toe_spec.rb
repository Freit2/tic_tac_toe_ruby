require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'tic_tac_toe'
require 'std_ui'

describe TicTacToe do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @ui = StdUI.new(@input, @output)
    @ttt = TicTacToe.new(@ui)
    TicTacToeEngine::TTT.initialize_cache
  end
  
  it "should be able to create a new instance" do
    lambda { TicTacToe.new }.should_not raise_error
  end

  it "should return player" do
    @ttt.ui.input.string = "h"
    @ttt.player('O').instance_of?(TicTacToeEngine::HumanPlayer)
    @ttt.ui.input.string = "e"
    @ttt.player('X').instance_of?(TicTacToeEngine::EasyCpuPlayer)
    @ttt.ui.input.string = "m"
    @ttt.player('X').instance_of?(TicTacToeEngine::CpuPlayer)
    @ttt.ui.input.string = "u"
    @ttt.player('X').instance_of?(TicTacToeEngine::NegamaxPlayer)
  end

  it "should create players" do
    @ttt.ui.input.string = "h\nu"
    @ttt.board_selection = '3x3'
    @ttt.create_players

    @ttt.player_o.ui.should equal(@ui)
    @ttt.player_x.ui.should equal(@ui)
  end

  it "should get board" do
    @ttt.ui.input.string = "1\n2\n3\n4"
    board = @ttt.board
    board.size.should == 9

    @ttt.ui.input.string = "a\nb\n4\n3"
    board_2 = @ttt.board
    board_2.size.should == 16
  end

  it "should play game" do
    @ttt.should_receive(:board).and_return(@ttt.board = mock("board"))
    @ttt.should_receive(:create_players)
    TicTacToeEngine::Game.should_receive(:new).and_return(@ttt.game = mock("game"))
    @ttt.game.should_receive(:scoreboard=)
    @ttt.game.should_receive(:play)
    @ttt.should_receive(:play_again?).and_return(false)
    @ttt.ui.should_receive(:display_exit_message)
    @ttt.play
  end

  it "should get play again" do
    @ttt.ui.input.string = "a\nb\ny"
    @ttt.play_again?.should == true

    @ttt.ui.input.string = "a\nb\nn"
    @ttt.play_again?.should == false
  end
end
