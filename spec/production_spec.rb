require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Production" do

  uses_scene "game_scene", :hidden => true, :stage => "default"

  it "should load require libraries" do
    production.should_receive(:require).exactly(3).times
    production.production_opening
  end

  it "should have instance variables" do
    production.production_loaded
    
    production.boards.size.should > 0
    production.players.size.should > 1
    production.board_selection.should == "3x3"
    production.player_o.should == "human"
    production.player_x.should == "unbeatable cpu"
  end
end