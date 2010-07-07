require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'min_max_player.rb'
require 'board'
require 'std_ui'
require 'stringio'

describe MinMaxPlayer do
  before(:each) do
    @x = 'X'
    @o = 'O'
    @b = ' '
    @ui = StdUI.new(StringIO.new, StringIO.new)
    @min_max = MinMaxPlayer.new(@x)
    @min_max.ui = @ui
    @board = Board.new
    @min_max.board = @board
  end

  it "should inherit from Player" do
    MinMaxPlayer.ancestors.include?(Player).should == true
  end

  it "should return correct opponent" do
    @min_max.get_opponent(@o).should == @x
    @min_max.get_opponent(@x).should == @o
  end

  it "should return 1 if Max is winner" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @min_max.evaluate_score(@board, @x, 3).should == 1
  end

  it "should return 2 if Max is winner in depth 2" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @min_max.evaluate_score(@board, @x, 2).should == 2
  end

  it "should return -1 if Min is winner" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @min_max.evaluate_score(@board, @x, 3).should == -1
  end

  it "should return -2 if Min is winner" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @min_max.evaluate_score(@board, @x, 2).should == -2
  end

  it "should return -1 if Max is winner (from Min POV)" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @min_max.evaluate_score(@board, @o, 3).should == -1
  end

  it "should return -2 if Max is winner in depth 2 (from Min POV)" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @min_max.evaluate_score(@board, @o, 2).should == -2
  end

  it "should return 1 if Min is winner (from Min POV)" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @min_max.evaluate_score(@board, @o, 3).should == 1
  end

  it "should return 1 if Min is winner in depth 2 (from Min POV)" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @min_max.evaluate_score(@board, @o, 2).should == 2
  end

  it "should return 0 if no one is winner" do
    board = Board.new([@x, @x, @o, @o, @x, @x, @x, @o, @o])
    @min_max.evaluate_score(board, @x, 5).should == 0
  end

  it "should make winning move, scenario 1" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)

    @min_max.make_move.should == 4
  end

  it "should make winning move, scenario 2" do
    @board.move(0, @o)
    @board.move(1, @x)
    @board.move(3, @o)
    @board.move(4, @o)
    @board.move(6, @x)
    @board.move(7, @x)

    @min_max.make_move.should == 8
  end

  it "should make winning move, scenario 3" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)
    @board.move(5, @o)
    @board.move(7, @x)

    @min_max.make_move.should == 4
  end

  it "should make winning move, scenario 4" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)
    @board.move(4, @x)
    @board.move(5, @o)
    @board.move(6, @o)

    @min_max.make_move.should == 8
  end

  it "should make winning move, scenario 5" do
    @board.move(0, @o)
    @board.move(1, @x)
    @board.move(2, @o)
    @board.move(4, @x)
    @board.move(8, @o)

    @min_max.make_move.should == 7
  end

  it "should make blocking move, scenario 1" do
    @board.move(0, @x)
    @board.move(3, @o)
    @board.move(4, @o)
    @min_max.make_move.should == 5
  end

  it "should make blocking move, scenario 2" do
    @board.move(0, @x)
    @board.move(4, @o)
    @board.move(8, @o)

    @min_max.make_move.should == 2
  end

  it "should make blocking move, scenario 3" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @o)
    @board.move(3, @x)

    @min_max.make_move.should_not == 4
  end

  it "should return a move fast, scenario 1" do
    @board.move(0, @o)

    before = Time.new
    @min_max.make_move
    (Time.new - before).should < 1
  end

  it "should use alpha beta pruning" do
    @board.move(0, @o)

    @min_max.should_receive(:get_alpha_beta_move)
    @min_max.make_move
  end

  it "should use mirrored moves method" do
    @board.move(0, @x)

    @min_max.should_receive(:get_mirrored_moves).and_return(0)
    @min_max.make_move
  end

  it "should return rotated moves" do
    @board.move(0, @o)
    @min_max.best_move = 2

    @min_max.get_mirrored_moves.should == [6,2]
  end
end

