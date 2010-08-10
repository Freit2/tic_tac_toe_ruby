require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'negamax_player.rb'
require 'std_ui'

describe NegamaxPlayer do
  before(:each) do
    @x = 'X'
    @o = 'O'
    @b = ' '
    @ui = StdUI.new(StringIO.new, StringIO.new)
    @cache = HashCache.new
    @board = Board.new
    @negamax = NegamaxPlayer.new(@x)
    @negamax.ui = @ui
    @negamax.cache = @cache
    @negamax.board = @board
  end

  it "should inherit from Player" do
    NegamaxPlayer.ancestors.include?(Player).should == true
  end

  it "should return correct opponent" do
    @negamax.opponent(@o).should == @x
    @negamax.opponent(@x).should == @o
  end

  it "should return 1 if Max is winner" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @negamax.evaluate_score(@board, @x, 3).should == 1
  end

  it "should return 2 if Max is winner in depth 2" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @negamax.evaluate_score(@board, @x, 2).should == 2
  end

  it "should return -1 if Min is winner" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @negamax.evaluate_score(@board, @x, 3).should == -1
  end

  it "should return -2 if Min is winner" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @negamax.evaluate_score(@board, @x, 2).should == -2
  end

  it "should return -1 if Max is winner (from Min POV)" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @negamax.evaluate_score(@board, @o, 3).should == -1
  end

  it "should return -2 if Max is winner in depth 2 (from Min POV)" do
    @board.move(0, @x)
    @board.move(1, @x)
    @board.move(2, @x)
    @negamax.evaluate_score(@board, @o, 2).should == -2
  end

  it "should return 1 if Min is winner (from Min POV)" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @negamax.evaluate_score(@board, @o, 3).should == 1
  end

  it "should return 2 if Min is winner in depth 2 (from Min POV)" do
    @board.move(0, @o)
    @board.move(1, @o)
    @board.move(2, @o)
    @negamax.evaluate_score(@board, @o, 2).should == 2
  end

  it "should return 0 if no one is winner" do
    board = Board.new([@x, @x, @o, @o, @x, @x, @x, @o, @o])
    @negamax.evaluate_score(board, @x, 5).should == 0
  end

  it "should make winning move, scenario 1" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)
    @negamax.should_receive(:rand).and_return(1)

    @negamax.make_move.should == 8
  end

  it "should make winning move, scenario 2" do
    @board.move(0, @o)
    @board.move(1, @x)
    @board.move(3, @o)
    @board.move(4, @o)
    @board.move(6, @x)
    @board.move(7, @x)

    @negamax.make_move.should == 8
  end

  it "should make winning move, scenario 3" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)
    @board.move(5, @o)
    @board.move(7, @x)

    @negamax.make_move.should == 4
  end

  it "should make winning move, scenario 4" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @x)
    @board.move(3, @o)
    @board.move(4, @x)
    @board.move(5, @o)
    @board.move(6, @o)

    @negamax.make_move.should == 8
  end

  it "should make winning move, scenario 5" do
    @board.move(0, @o)
    @board.move(1, @x)
    @board.move(2, @o)
    @board.move(4, @x)
    @board.move(8, @o)

    @negamax.make_move.should == 7
  end

  it "should make winning move, scenario 6" do
    board = Board.new(nil, 16)
    @negamax.board = board
    board.move(0, @o)
    board.move(1, @x)
    board.move(2, @o)
    board.move(3, @x)
    board.move(4, @o)
    board.move(6, @x)
    board.move(9, @o)
    board.move(10,@o)
    board.move(11,@x)
    board.move(12,@o)
    board.move(15,@x)

    @negamax.make_move.should == 7
  end

  it "should make blocking move, scenario 1" do
    @board.move(0, @x)
    @board.move(3, @o)
    @board.move(4, @o)
    @negamax.make_move.should == 5
  end

  it "should make blocking move, scenario 2" do
    @board.move(0, @x)
    @board.move(4, @o)
    @board.move(8, @o)
    @negamax.should_receive(:rand).and_return(0)

    @negamax.make_move.should == 2
  end

  it "should make blocking move, scenario 3" do
    @board.move(0, @x)
    @board.move(1, @o)
    @board.move(2, @o)
    @board.move(3, @x)

    @negamax.make_move.should_not == 4
  end

  it "should make blocking move, scenario 4" do
    board = Board.new(nil, 16)
    @negamax.board = board
    board.move(0, @o)
    board.move(1, @x)
    board.move(2, @x)
    board.move(3, @o)
    board.move(4, @o)
    board.move(6, @x)
    board.move(7, @o)
    board.move(8, @o)

    @negamax.make_move.should == 12
  end

  it "should return a move fast, scenario 1" do
    @board.move(0, @o)

    pending("Takes longer since it's using new hash") {
      before = Time.new
      @negamax.make_move
      (Time.new - before).should < 1
    }
  end

  it "should return a move fast, scenario 2" do
    negamax = NegamaxPlayer.new(@o)
    negamax.ui = @ui
    negamax.cache = HashCache.new
    negamax.board = @board

    pending("Takes longer since it's using new hash")
    before = Time.new
    negamax.make_move
    (Time.new - before).should < 1
  end

  it "should use negamax" do
    @board.move(0, @o)

    @negamax.should_receive(:negamax)
    @negamax.make_move
  end

  it "should return indexes of max" do
    array = [0,1,1,0]
    @negamax.indexes_of_max(array).should == [1,2]
  end

  it "should return the best random move" do
    @negamax.scores = [0, 1, 0, 0, 1, 0, 1, 0, -1]
    @negamax.should_receive(:rand).and_return(1)

    @negamax.best_random_move.should == 4
  end
end

