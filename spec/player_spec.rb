# player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'player'

describe Player do
  it "returns O for piece when creating player" do
    player = Player.new('O')
    player.piece.should == 'O'
  end
end


