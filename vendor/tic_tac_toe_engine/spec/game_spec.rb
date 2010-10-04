require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'human_player'
require 'cpu_player'
require 'std_ui'

describe TicTacToeEngine::Game do
  before(:each) do
    File.delete("test.csv") if File.exists?("test.csv")
    @input = StringIO.new
    @output = StringIO.new
    @board = TicTacToeEngine::Board.new
    @ui = StdUI.new(@input, @output)
    @player_o = TicTacToeEngine::HumanPlayer.new('O')
    @player_x = TicTacToeEngine::CpuPlayer.new('X')
    @player_o.ui = @ui
    @player_x.ui = @ui
    @scoreboard = TicTacToeEngine::Scoreboard.new("test.csv")
    @game = TicTacToeEngine::Game.new(@player_o, @player_x, @board, @ui)
    @game.scoreboard = @scoreboard
  end

  after(:all) do
    File.delete("test.csv") if File.exists?("test.csv")
  end

  it "should hold two different players" do
    @game.player_o.should be(@player_o)
    @game.player_x.should be(@player_x)
  end

  it "should hold a board" do
    @game.board.should be(@board)
  end

  it "should hold a ui" do
    @game.ui.should be(@ui)
  end

  it "should hold a scoreboard" do
    @game.scoreboard.should be(@scoreboard)
  end

  it "should return a move for human player" do
    @ui.input.string = '1'
    @game.move_from(@player_o).should == 1
  end

  it "should return a move from cpu player" do
    @player_x.should_receive(:rand).and_return(1)
    @game.move_from(@player_x).should == 4
    @player_x.should_receive(:rand).twice.and_return(0)
    @game.move_from(@player_x).should == 0
  end
  
  it 'continues to ask a player for a valid move' do
    @player_o.should_receive(:make_move).twice.and_return(-1)
    @player_o.should_receive(:make_move).once.and_return(0)
    @game.move_from(@player_o).should == 0
  end

  it "should allow up to nine turns" do
    @player_o.should_receive(:piece).exactly(5).times.and_return('X')
    @player_x.should_receive(:piece).exactly(4).times.and_return('O')
    @player_o.should_receive(:make_move).and_return(0)
    @player_o.should_receive(:make_move).and_return(2)
    @player_o.should_receive(:make_move).and_return(3)
    @player_o.should_receive(:make_move).and_return(5)
    @player_o.should_receive(:make_move).and_return(7)
    @player_x.should_receive(:make_move).and_return(1)
    @player_x.should_receive(:make_move).and_return(4)
    @player_x.should_receive(:make_move).and_return(6)
    @player_x.should_receive(:make_move).and_return(8)

    @game.play
  end

  it "should stop playing after someone wins" do
    @player_o.should_receive(:piece).exactly(3).times.and_return('X')
    @player_x.should_receive(:piece).exactly(2).times.and_return('O')
    @player_o.should_receive(:make_move).and_return(0)
    @player_x.should_receive(:make_move).and_return(3)
    @player_o.should_receive(:make_move).and_return(1)
    @player_x.should_receive(:make_move).and_return(4)
    @player_o.should_receive(:make_move).and_return(2)

    @game.play
  end

  it "should receive messages when game ends" do
    @player_o.should_receive(:piece).exactly(3).times.and_return('X')
    @player_x.should_receive(:piece).exactly(2).times.and_return('O')
    @player_o.should_receive(:make_move).and_return(0)
    @player_x.should_receive(:make_move).and_return(3)
    @player_o.should_receive(:make_move).and_return(1)
    @player_x.should_receive(:make_move).and_return(4)
    @player_o.should_receive(:make_move).and_return(2)

    @game.should_receive(:display_end_message)
    @game.scoreboard.should_receive(:add_scores)
    @game.ui.should_receive(:display_scores)
    @game.ui.should_receive(:display_try_again)

    @game.play
  end
end
