require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'scoreboard'
require 'std_ui'

describe Scoreboard do
  before(:each) do
    File.delete("test.csv") if File.exists?("test.csv")
    @scoreboard = Scoreboard.new("test.csv")
  end

  after(:all) do
    File.delete("test.csv") if File.exists?("test.csv")
  end

  it "should hold a hash in instance variable" do
    @scoreboard.scores.class.should == Hash
  end

  it "should have o and x keys" do
    @scoreboard.scores.keys.include?(:o).should == true
    @scoreboard.scores.keys.include?(:x).should == true
  end

  it "should add a win to player O" do
    @scoreboard.add_scores('O')
    @scoreboard.wins(:o).should == 1
    @scoreboard.losses(:o).should == 0
    @scoreboard.draws(:o).should == 0
    @scoreboard.wins(:x).should == 0
    @scoreboard.losses(:x).should == 1
    @scoreboard.draws(:x).should == 0
  end

  it "should add a win to player X" do
    @scoreboard.add_scores('X')

    @scoreboard.wins(:o).should == 0
    @scoreboard.losses(:o).should == 1
    @scoreboard.draws(:o).should == 0
    @scoreboard.wins(:x).should == 1
    @scoreboard.losses(:x).should == 0
    @scoreboard.draws(:x).should == 0
  end

  it "should add a draw to players" do
    @scoreboard.add_scores(nil)

    @scoreboard.wins(:o).should == 0
    @scoreboard.losses(:o).should == 0
    @scoreboard.draws(:o).should == 1
    @scoreboard.wins(:x).should == 0
    @scoreboard.losses(:x).should == 0
    @scoreboard.draws(:x).should == 1
  end

  it "should return player's hash" do
    TTT::CONFIG.pieces.values.each do |p|
      @scoreboard.add_scores(p)
      p = p.downcase
      @scoreboard[p][:wins].should == @scoreboard.wins(p)
      @scoreboard[p][:losses].should == @scoreboard.losses(p)
      @scoreboard[p][:draws].should == @scoreboard.draws(p)
    end
  end

  it "should store csv path" do
    @scoreboard.csv_path.should_not be_nil
  end

  it "should read the scores from csv" do
    @scoreboard.read_scores
    @scoreboard.scores.keys.include?(:o).should be_true
    @scoreboard.scores.keys.include?(:x).should be_true
  end

  it "should write the scores to csv" do
    scores = {:o => { :wins => 2, :draws => 1, :losses => 0},
              :x => { :wins => 0, :draws => 1, :losses => 2}}
    scoreboard = Scoreboard.new("test.csv")
    scoreboard.scores = scores
    scoreboard.write_scores
    scoreboard.read_scores
    scoreboard.scores.should == scores
    File.delete("test.csv") if File.exists?("test.csv")
  end
end
