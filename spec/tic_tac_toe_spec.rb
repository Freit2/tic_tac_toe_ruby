require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'tic_tac_toe'
require 'human_player'
require 'cpu_player'
require 'std_ui'

describe TicTacToe do
  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @ui = StdUI.new(@input, @output)
    @ttt = TicTacToe.new(@ui)
  end
  
  it "should be able to create a new instance" do
    lambda { TicTacToe.new }.should_not raise_error
  end

  it "should return player" do
    @ttt.ui.input.string = "h"
    @ttt.ask_for_player('O').instance_of?(HumanPlayer)
    @ttt.ui.input.string = "c"
    @ttt.ask_for_player('X').instance_of?(CpuPlayer)
  end
end
