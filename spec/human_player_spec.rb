# human_player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"   
require 'human_player'

describe HumanPlayer do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @human = HumanPlayer.new('O', @input, @output)
  end

  it "should inherit from Player" do
    HumanPlayer.ancestors.include?(Player).should == true
  end

  it "should not make a nil move" do
    @human.make_move.should_not be_nil
  end

  it "should return a move from std in" do
    @input.string = '4'
    @human.make_move.should == 4
  end

  it "should display message to player" do
    @human.make_move
    @output.string.should == "\nEnter your move, player 'O' [0-8]: "
  end
end
