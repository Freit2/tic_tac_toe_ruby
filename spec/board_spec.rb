require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'board'

describe Board do
  before(:each) do
    @board = Board.new
    @x = 'X'
    @o = 'O'
  end

  it "returns size for board" do
    @board.size.should == 9
  end

  it "should accept existing board array" do
    board = [@x, @o, @x, @o, @x, @o, @o, @o, @x]
    new_board = Board.new(board)
    new_board.to_s.should == "XOXOXOOOX"
  end

  it "occupies square if move is made" do
    @board.move(0, @x)
    @board.occupied?(0).should == true
  end

  it "does not occupy square if square is already occupied" do
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
    @board.winner.should be_nil
    @board.game_over?.should == true
  end

  it "returns true if someone wins" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @board.winner.should == @x
    @board.win_moves.should == [0,1,2]
    @board.someone_win?.should == true
  end

  it "should return true for a valid move" do
    9.times do |s|
      @board.valid_move?(s).should == true
    end
  end

  it "returns pieces for specific squares" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.piece_in(0).should == @x
    @board.piece_in(1).should == @o
  end

  it "returns an array of empty squares" do
    @board.get_empty_squares.size.should == 9
    @board.move(0, @x)
    @board.get_empty_squares.size.should == 8
  end

  it "returns last move" do
    @board.move(0, @x)
    @board.last_move.should == 0
    @board.move(1, @o)
    @board.last_move.should == 1
    @board.move(0, @o)
    @board.last_move.should == 1
  end

  it "should have winning patterns with three elements" do
    @board.winning_patterns.each do |w|
      w.size.should == 3
      w[1].class.should == Array
      w[1].size.should == 3
    end
  end
end
