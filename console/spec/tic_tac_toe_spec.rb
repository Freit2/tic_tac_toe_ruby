require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'tic_tac_toe'
require 'human_player'
require 'cpu_player'
require 'std_ui'
require 'score_board'

describe TicTacToe do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @ui = StdUI.new(@input, @output)
    @ttt = TicTacToe.new(@ui)
    @ttt.initialize_cache
  end
  
  it "should be able to create a new instance" do
    lambda { TicTacToe.new }.should_not raise_error
  end

  it "should return player" do
    @ttt.ui.input.string = "h"
    @ttt.get_player('O').instance_of?(HumanPlayer)
    @ttt.ui.input.string = "e"
    @ttt.get_player('X').instance_of?(EasyCpuPlayer)
    @ttt.ui.input.string = "m"
    @ttt.get_player('X').instance_of?(CpuPlayer)
    @ttt.ui.input.string = "u"
    @ttt.get_player('X').instance_of?(NegamaxPlayer)
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
    board = @ttt.get_board
    board.size.should == 9

    @ttt.ui.input.string = "a\nb\n4\n3"
    board_2 = @ttt.get_board
    board_2.size.should == 16
  end

  it "should play game" do
    @ttt.should_receive(:get_board).and_return(@ttt.board = mock("board"))
    @ttt.should_receive(:create_players)
    Game.should_receive(:new).and_return(@ttt.game = mock("game"))
    @ttt.game.should_receive(:play)
    @ttt.board.should_receive(:winner).and_return(winner = mock("winner"))
    @ttt.score_board.should_receive(:add_score).with(winner)
    @ttt.score_board.should_receive(:display_scores)
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

  it "should create an instance of ScoreBoard" do
    ScoreBoard.should_receive(:new).and_return(score_board = mock("score_board"))
    score_board.should_receive(:ui=)
    ttt = TicTacToe.new
    ttt.score_board.should == score_board
  end
end
