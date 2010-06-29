require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'easy_cpu_player'
require 'board'
require 'std_ui'
require 'stringio'

describe EasyCpuPlayer do
  before(:each) do
    @ui = StdUI.new(StringIO.new, StringIO.new)
    @easy_cpu = EasyCpuPlayer.new('X')
    @easy_cpu.ui = @ui
    @board = Board.new
    @easy_cpu.board = @board
  end

  it "should inherit from Player" do
    EasyCpuPlayer.ancestors.include?(Player).should == true
  end

  it "should not make a nil move" do
    @easy_cpu.make_move.should_not be_nil
  end

  it "should make legal board move" do
    @easy_cpu.make_move.to_s.should  =~ /[0-#{@board.size}]/
  end

  it "should make move" do
    @easy_cpu.should_receive(:rand).and_return(0)
    @easy_cpu.should_receive(:rand).and_return(4)
    @easy_cpu.should_receive(:rand).and_return(8)
    
    @easy_cpu.make_move.should == 0
    @easy_cpu.make_move.should == 4
    @easy_cpu.make_move.should == 8
  end
end