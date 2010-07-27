require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Options Scene" do

  uses_scene "options_scene", :hidden => true

  before(:all) do
    production.production_opening
  end

  before(:each) do
    production.production_loaded
  end

  it "should have three menu props" do
    count = 0
    scene.children.each do |p|
      if p.name == "menu"
        count += 1
      end
    end

    count.should == 3
  end

  it "should have one button menu prop" do
    count = 0
    scene.children.each do |p|
      if p.name == "button_menu"
        count += 1
      end
    end

    count.should == 1
  end

  it "should default to 3x3 board" do
    scene.board_selection.text.should == '3x3'
  end

  it "should default to human and minmax players" do
    scene.player_o_type.text.should == 'human'
    scene.player_x_type.text.should == 'unbeatable cpu'
  end

  it "should have default scene as options_scene" do
    production.theater["options"].default_scene == "options_scene"
  end

  it "should hide when starting new game" do
    scene.stage.should_receive(:hide)
    scene.should_receive(:open_default_scene)

    scene.play_new_game
  end

  it "should close" do
    scene.stage.should_receive(:close)

    scene.close
  end
end