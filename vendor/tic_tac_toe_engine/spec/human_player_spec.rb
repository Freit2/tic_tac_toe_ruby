require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"   
require 'human_player'
require 'std_ui'

describe TicTacToeEngine::HumanPlayer do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @ui = StdUI.new(@input, @output)
    @human = TicTacToeEngine::HumanPlayer.new('O')
    @human.ui = @ui
  end

  it "should inherit from Player" do
    TicTacToeEngine::HumanPlayer.ancestors.include?(TicTacToeEngine::Player).should == true
  end

  it "should not make a nil move" do
    @human.make_move.should_not be_nil
  end

  it "should return a move from input" do
    @input.string = '4'
    @human.make_move.should == 4
  end

  it "should display message to player" do
    @human.make_move
    @output.string.should == "\nEnter your move, player 'O': "
  end
end
