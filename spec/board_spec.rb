# board_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'board'

describe Board do
  before(:each) do
    @std_out = StringIO.new
    @board = Board.new(@std_out)
    @x = 'X'
    @o = 'O'
  end

  it "returns true if move is 0-8" do
    (0..8).each do
      |s| @board.valid_move?(s).should == true
    end
  end

  it "returns false if move is not 0-8" do
    @board.valid_move?(9).should == false
  end

  it "occupies space if move is made within valid range" do
    @board.move(0, @x)
    @board.occupied?(0).should == true
  end

  it "does not occupy space if move is made not within range" do
    @board.move(9, @x)
    @board.occupied?(9).should == false
  end

  it "returns true if someone wins" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @board.game_over?.should == true
  end

  it "returns true if it finds match from pattern set" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @board.someone_win?.should == true
    @board.winner.should == @x
  end

  it "returns pieces for specific squares" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.piece_in(0).should == @x
    @board.piece_in(1).should == @o
  end

  it "should have display print board on std_out" do
    9.times do |x|
      @board.move(x, @x)
    end
    @board.std_out.should_receive(:print).with("\n\n")
    @board.std_out.should_receive(:print).with(" #{@x} |")
    @board.std_out.should_receive(:print).with(" #{@x} |")
    @board.std_out.should_receive(:print).with(" #{@x}")
    @board.std_out.should_receive(:print).with("\n---+---+---\n")
    @board.std_out.should_receive(:print).with(" #{@x} |")
    @board.std_out.should_receive(:print).with(" #{@x} |")
    @board.std_out.should_receive(:print).with(" #{@x}")
    @board.std_out.should_receive(:print).with("\n---+---+---\n")
    @board.std_out.should_receive(:print).with(" #{@x} |")
    @board.std_out.should_receive(:print).with(" #{@x} |")
    @board.std_out.should_receive(:print).with(" #{@x}")
    @board.std_out.should_receive(:print).with("\n\n")
    @board.display
  end
end
