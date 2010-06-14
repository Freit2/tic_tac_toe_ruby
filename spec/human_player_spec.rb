# human_player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"   
require 'human_player'
require 'stringio'

describe HumanPlayer do
  before(:each) do
    @std_in = StringIO.new
    @std_out = StringIO.new
    @human = HumanPlayer.new('O', @std_in, @std_out)
    @test_move = 4
  end

  it "should be able to return type of player" do
    @human.type.should == 'human'
  end

  it "should not make a nil move" do
    @human.make_move.should_not be_nil
  end

  it "should return a move from std in" do
    @std_in.string = @test_move.to_s
    @human.make_move.should == @test_move
  end

  it "should display message to player" do
    @human.std_out.should_receive(:print).with("\nEnter your move, player 'O' [0-8]: ")
    @human.make_move
  end

  it "should allow arguments to be accepted" do
    @human.make_move(0, 1, 2, 3)
  end
end
