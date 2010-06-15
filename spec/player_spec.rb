# player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'player'
require 'board'

describe Player do
  it "returns O for piece when creating player" do
    player = Player.new('O')
    player.piece.should == 'O'
  end

  it "should allow board to be set" do
    board = Board.new(STDIN)
    player = Player.new('X')
    player.board = board
    player.board.should == board
  end
end


