require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Production" do

  uses_scene "game_scene", :hidden => true, :stage => "options"

  it "should load require libraries" do
    production.should_receive(:require).exactly(4).times
    production.production_opening
  end

  it "should have instance variables" do
    production.production_loaded
    
    production.boards.size.should > 0
    production.players.size.should > 1
    production.board_selection.should == "3x3"
    production.player_selection.first[:value].should == "human"
    production.player_selection.last[:value].should == "unbeatable"
  end
end