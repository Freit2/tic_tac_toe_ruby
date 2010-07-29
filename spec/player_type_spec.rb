require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Player Type" do

  uses_scene "options_scene", :hidden => true

  before(:all) do
    production.production_opening
  end

  before(:each) do
    production.production_loaded
  end

  it "should use correct image for selected player" do
    prop_o = scene.find("player_o_med")
    prop_o.mouse_clicked(nil)

    prop_o.style.background_image.should_not =~ /dim/

    prop_x = scene.find("player_x_med")
    prop_x.mouse_clicked(nil)

    prop_x.style.background_image.should_not =~ /dim/
  end

  it "should not affect other player's selection" do
    prop_o = scene.find("player_o_med")
    prop_x = scene.find("player_x_easy")

    prop_x.mouse_clicked(nil)
    prop_o.mouse_clicked(nil)

    prop_x.style.background_image.should_not =~ /dim/

    prop_x.mouse_clicked(nil)

    prop_o.style.background_image.should_not =~ /dim/
  end

  it "should use correct images for non-selected players" do
    prop_o = scene.find("player_o_med")
    prop_o.mouse_clicked(nil)

    scene.find("player_o_human").style.background_image.should =~ /dim/
    scene.find("player_o_easy").style.background_image.should =~ /dim/
    scene.find("player_o_hard").style.background_image.should =~ /dim/

    prop_x = scene.find("player_x_med")
    prop_x.mouse_clicked(nil)

    scene.find("player_x_human").style.background_image.should =~ /dim/
    scene.find("player_x_easy").style.background_image.should =~ /dim/
    scene.find("player_x_hard").style.background_image.should =~ /dim/
  end

  it "should not affect other player's non-selected images" do
    prop_o = scene.find("player_o_med")
    prop_x = scene.find("player_x_easy")

    prop_x.mouse_clicked(nil)
    prop_o.mouse_clicked(nil)

    scene.find("player_x_easy").style.background_image.should_not =~ /dim/
    scene.find("player_x_med").style.background_image.should =~ /dim/

    prop_x.mouse_clicked(nil)

    scene.find("player_o_easy").style.background_image.should =~ /dim/
    scene.find("player_o_med").style.background_image.should_not =~ /dim/
  end

  it "should store player selection" do
    prop_o = scene.find("player_o_hard")
    prop_x = scene.find("player_x_easy")

    prop_o.mouse_clicked(nil)
    production.player_selection.first[:name].should == "hard"
    production.player_selection.first[:value].should == "unbeatable"

    prop_x.mouse_clicked(nil)
    production.player_selection.last[:name].should == "easy"
    production.player_selection.last[:value].should == "easy"
  end
end