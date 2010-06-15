#cpu_player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"   
require 'cpu_player'
require 'board'

describe CpuPlayer do
  before(:each) do
    @cpu = CpuPlayer.new('X')
    @std_out = StringIO.new
    @board = Board.new(@std_out)
    @cpu.board = @board
  end

  it "should inherit from Player" do
    CpuPlayer.ancestors.include?(Player).should == true
  end

  it "should not make a nil move" do
    @cpu.make_move.should_not be_nil
  end

  it "should return a move from winning pattern set" do
    @board.move(0, 'X')
    @board.move(1, 'X')
    @cpu.get_winning_pattern_move.should == 2
  end

  it "should return a move from blocking pattern set" do
    @board.move(0, 'O')
    @board.move(1, 'O')
    @cpu.get_blocking_pattern_move.should == 2
  end

  it "should move to position 4 if available" do
    @board.move(0, 'X')
    @board.move(2, 'O')
    @cpu.get_first_available_move.should == 4
  end

  it "should return a move for first available" do
    @board.move(0, 'X')
    @board.move(2, 'O')
    @board.move(4, 'X')
    @cpu.get_first_available_move.should == 1
  end
end
