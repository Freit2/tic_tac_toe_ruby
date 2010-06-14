#cpu_player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"   
require 'cpu_player'
require 'stringio'
require 'board'

describe CpuPlayer do
  before(:each) do
    @cpu = CpuPlayer.new('X')
    @std_out = StringIO.new
    @board = Board.new(@std_out)
  end

  it "should be able to return type of player" do
    @cpu.type.should == 'cpu'
  end

  it "should not make a nil move" do
    @cpu.make_move(@board).should_not be_nil
  end

  it "should return a move from regular expression pattern set" do
    @cpu.should_receive(:get_winning_pattern_move).and_return(nil)
    @cpu.should_receive(:get_blocking_pattern_move).and_return(nil)
    @cpu.should_receive(:get_first_available_move).and_return(0)
    @cpu.make_move(@board)
  end

#  it "should return a move from minmax algorithm" do
#    @cpu.should_receive(:get_minmax_move).and_return(4)
#    @cpu.make_move.should_not be_nil
#  end
end
