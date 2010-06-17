# min_max_player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'min_max_player.rb'
require 'board'
require 'ui'
require 'stringio'

describe MinMaxPlayer do
  before(:each) do
    @x = 'X'
    @o = 'O'
    @b = ' '
    @ui = UI.new(StringIO.new, StringIO.new)
    @min_max = MinMaxPlayer.new(@x)
    @min_max.ui = @ui
    @board = Board.new
    @min_max.board = @board
  end

  it "should inherit from Player" do
    MinMaxPlayer.ancestors.include?(Player).should == true
  end

  it "should return 1 if Max is winner" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @min_max.eval_piece = @x
    @min_max.evaluate_score(@board).should == 1
  end

  it "should return -1 if Min is winner" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @min_max.eval_piece = @x
    @min_max.evaluate_score(@board).should == -1
  end

  it "should return -1 if Max is winner (from Min POV)" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @min_max.eval_piece = @o
    @min_max.evaluate_score(@board).should == -1
  end

  it "should return 1 if Min is winner (from Min POV)" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @min_max.eval_piece = @o
    @min_max.evaluate_score(@board).should == 1
  end

  it "should return 0 if no one is winner" do
    board = Board.new([@x, @x, @o, @o, @x, @x, @x, @o, @o])
    @min_max.eval_piece = @x
    @min_max.evaluate_score(board).should == 0
  end

  it "should" do
    @board.move(0, @b)
    @board.move(1, @b)
    @board.move(2, @b)
    @board.move(3, @b)
    @board.move(4, @x)
    @board.move(5, @b)
    @board.move(6, @b)
    @board.move(7, @b)
    @board.move(8, @b)
    @min_max.make_move
  end

#  it "should make winning move" do
#    @board.move(0, @x)
#    @board.move(1, @o)
#    @board.move(2, @x)
#    @board.move(3, @o)
#    @board.move(4, @x)
#    @board.move(5, @o)
#    @board.move(6, @o)
#
#    @min_max.make_move.should == 8
#  end
#
#  it "should make winning move, scenario 1" do
#    @board.move(3, 'X')
#    @board.move(4, 'X')
#    @min_max.make_move.should == 5
#  end
#
#  it "should make blocking move, scenario 1" do
#    @board.move(3, 'O')
#    @board.move(4, 'O')
#    @min_max.make_move.should == 5
#  end
#
#  it "should make winning move, scenario 2" do
#    @board.move(0, 'X')
#    @board.move(4, 'X')
#    @min_max.make_move.should == 8
#  end
#  it "should make blocking move, scenario 2" do
#    @board.move(0, 'O')
#    @board.move(8, 'O')
#    @min_max.make_move.should == 4
#  end
end

