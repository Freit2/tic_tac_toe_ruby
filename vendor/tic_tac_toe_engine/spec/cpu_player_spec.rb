require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'cpu_player'
require 'std_ui'

describe TicTacToeEngine::CpuPlayer do
  before(:each) do
    @ui = StdUI.new(StringIO.new, StringIO.new)
    @cpu = TicTacToeEngine::CpuPlayer.new('X')
    @cpu.ui = @ui
    @board = TicTacToeEngine::Board.new
    @cpu.board = @board
  end

  it "should inherit from Player" do
    TicTacToeEngine::CpuPlayer.ancestors.include?(TicTacToeEngine::Player).should == true
  end

  it "should not make a nil move" do
    @cpu.make_move.should_not be_nil
  end

  it "should return a move from winning pattern set" do
    @board.move(0, 'X')
    @board.move(1, 'X')
    @cpu.winning_pattern_move.should == 2
  end

  it "should return a move from blocking pattern set" do
    @board.move(0, 'O')
    @board.move(1, 'O')
    @cpu.blocking_pattern_move.should == 2
  end

  it "should move to position 4 if available" do
    @board.move(0, 'X')
    @board.move(2, 'O')
    @cpu.first_available_move.should == 4
  end

  it "should return a move for first available" do
    @board.move(0, 'X')
    @board.move(2, 'O')
    @board.move(4, 'X')
    @cpu.first_available_move.should == 1
  end
  
  it "should return a random move" do
    @cpu.should_receive(:rand).and_return(0)
    @cpu.should_receive(:rand).and_return(5)
    @board.move(0, 'X')
    @board.move(1, 'X')
    @cpu.make_move.should == 5
  end
end
