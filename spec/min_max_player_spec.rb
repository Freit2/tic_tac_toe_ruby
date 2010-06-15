# min_max_player_spec.rb
require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'min_max_player.rb'
require 'player'

describe MinMaxPlayer do
  it "should inherit from Player" do
    MinMaxPlayer.ancestors.include?(Player).should == true
  end
end

