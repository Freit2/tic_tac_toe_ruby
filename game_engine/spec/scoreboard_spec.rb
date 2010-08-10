require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'scoreboard'
require 'std_ui'

describe Scoreboard do
  before(:each) do
    @scoreboard = Scoreboard.new
  end

  it "should hold a hash in instance variable" do
    @scoreboard.scores.class.should == Hash
  end

  it "should have o and x keys" do
    @scoreboard.scores.keys.include?(:o).should == true
    @scoreboard.scores.keys.include?(:x).should == true
  end

  it "should add a win to player O" do
    @scoreboard.add_score('O')

    @scoreboard.wins(:o).should == 1
    @scoreboard.losses(:o).should == 0
    @scoreboard.draws(:o).should == 0
    @scoreboard.wins(:x).should == 0
    @scoreboard.losses(:x).should == 1
    @scoreboard.draws(:x).should == 0
  end

  it "should add a win to player X" do
    @scoreboard.add_score('X')

    @scoreboard.wins(:o).should == 0
    @scoreboard.losses(:o).should == 1
    @scoreboard.draws(:o).should == 0
    @scoreboard.wins(:x).should == 1
    @scoreboard.losses(:x).should == 0
    @scoreboard.draws(:x).should == 0
  end

  it "should add a draw to players" do
    @scoreboard.add_score(nil)

    @scoreboard.wins(:o).should == 0
    @scoreboard.losses(:o).should == 0
    @scoreboard.draws(:o).should == 1
    @scoreboard.wins(:x).should == 0
    @scoreboard.losses(:x).should == 0
    @scoreboard.draws(:x).should == 1
  end

  it "should return player's hash" do
    TTT::CONFIG.pieces.values.each do |p|
      @scoreboard.add_score(p)
      p = p.downcase
      @scoreboard[p][:wins].should == @scoreboard.wins(p)
      @scoreboard[p][:losses].should == @scoreboard.losses(p)
      @scoreboard[p][:draws].should == @scoreboard.draws(p)
    end
  end
end
