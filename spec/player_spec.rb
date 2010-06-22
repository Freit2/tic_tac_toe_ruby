require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'player'
require 'board'
require 'ui'

describe Player do
  it "returns O for piece when creating player" do
    player = Player.new('O')
    player.piece.should == 'O'
  end

  it "should allow board to be set" do
    board = Board.new
    player = Player.new('X')
    player.board = board
    player.board.should == board
  end

  it "should allow ui to be set" do
    ui = UI.new(STDIN, STDOUT)
    player = Player.new('X')
    player.ui = ui
    player.ui.should == ui
  end  
end


