require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'score_board'
require 'std_ui'

describe ScoreBoard do
  before(:each) do
    @score_board = ScoreBoard.new
  end

  it "should hold a hash in instance variable" do
    @score_board.scores.class.should == Hash
  end

  it "should have o and x keys" do
    @score_board.scores.keys.include?(:o).should == true
    @score_board.scores.keys.include?(:x).should == true
  end

  it "should add a win to player O" do
    @score_board.add_score('O')

    @score_board.wins(:o).should == 1
    @score_board.losses(:o).should == 0
    @score_board.draws(:o).should == 0
    @score_board.wins(:x).should == 0
    @score_board.losses(:x).should == 1
    @score_board.draws(:x).should == 0
  end

  it "should add a win to player X" do
    @score_board.add_score('X')

    @score_board.wins(:o).should == 0
    @score_board.losses(:o).should == 1
    @score_board.draws(:o).should == 0
    @score_board.wins(:x).should == 1
    @score_board.losses(:x).should == 0
    @score_board.draws(:x).should == 0
  end

  it "should add a draw to players" do
    @score_board.add_score(nil)

    @score_board.wins(:o).should == 0
    @score_board.losses(:o).should == 0
    @score_board.draws(:o).should == 1
    @score_board.wins(:x).should == 0
    @score_board.losses(:x).should == 0
    @score_board.draws(:x).should == 1
  end
end
