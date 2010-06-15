# tictactoe_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'tic_tac_toe'
require 'human_player'
require 'cpu_player'

describe TicTacToe do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @ttt = TicTacToe.new(@input, @output)
  end
  
  it "should be able to create a new instance" do
    lambda { TicTacToe.new(@input, @output) }.should_not raise_error
  end

  it "should allow change to stdin" do
    ttt = TicTacToe.new(STDIN, STDOUT)
    ttt.input.should == STDIN
    @ttt.input.should == @input
  end

  it "should allow change to stdout" do
    ttt = TicTacToe.new(STDIN, STDOUT)
    ttt.output.should == STDOUT
    @ttt.output.should == @output
  end

#  it "should ask player types for both players" do
#    player1 = HumanPlayer.new('O', @std_in, @std_out)
#    player2 = CpuPlayer.new('X')
#    @ttt.should_receive(:choose_players)
#    @ttt.game.player1.should_receive(:make_move).and_return(0)
#    @ttt.game.player2.should_receive(:make_move).and_return(3)
#    @ttt.game.player1.should_receive(:make_move).and_return(1)
#    @ttt.game.player2.should_receive(:make_move).and_return(4)
#    @ttt.game.player1.should_receive(:make_move).and_return(2)
#    @ttt.play
#  end

  it "should return player" do
    @ttt.input.string = "h"
    @ttt.ask_for_player('O').instance_of?(HumanPlayer)
    @ttt.input.string = "c"
    @ttt.ask_for_player('X').instance_of?(CpuPlayer)
  end

#  it "should play a new game on start" do
#    @ttt.game.instance_of?(Game)
#    @ttt.play
#  end
end
