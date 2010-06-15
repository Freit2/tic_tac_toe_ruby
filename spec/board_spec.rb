# board_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'board'

describe Board do
  before(:each) do
    @output = StringIO.new
    @board = Board.new(@output)
    @x = 'X'
    @o = 'O'
  end

  it "occupies space if move is made" do
    @board.move(0, @x)
    @board.occupied?(0).should == true
  end

  it "does not occupy space if space is already occupied" do
    @board.move(0, @x)
    @board.move(0, @o)
    @board.piece_in(0).should == @x
  end

  it "returns true if game is over" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)
    @board.move(4, @o)
    @board.move(5, @x)
    @board.move(6, @x)
    @board.move(7, @x)
    @board.move(8, @o)
    @board.game_over?.should == true
  end

  it "returns true if someone wins" do
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
    9.times do |s|
      @board.move(s, @x)
    end
    @board.output.should_receive(:print).with("\n\n")
    @board.output.should_receive(:print).with(" #{@x} | #{@x} | #{@x} ")
    @board.output.should_receive(:print).with("\n---+---+---\n")
    @board.output.should_receive(:print).with(" #{@x} | #{@x} | #{@x} ")
    @board.output.should_receive(:print).with("\n---+---+---\n")
    @board.output.should_receive(:print).with(" #{@x} | #{@x} | #{@x} ")
    @board.output.should_receive(:print).with("\n\n")
    @board.display
  end
end
