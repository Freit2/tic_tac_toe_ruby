require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Production" do

  uses_scene "game_scene", :hidden => true, :stage => "default"

  it "should be the game engine's UI" do
    production.production_opening
    scene
    production.production_opened

    #production.tic_tac_toe.ui.should == scene
  end

end