require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Board Type" do

  uses_scene "options_scene", :hidden => true

  before(:all) do
    production.production_opening
  end

  before(:each) do
    production.production_loaded
  end

  it "should store board selection of clicked board type" do
    scene.find("board_3x3").mouse_clicked(nil)
    production.board_selection.should == "3x3"
    scene.find("board_4x4").mouse_clicked(nil)
    production.board_selection.should == "4x4"
  end

  it "should set background image" do
    scene.find("board_3x3").mouse_clicked(nil)
    scene.find("board_3x3").style.background_image.should_not =~ /dim/
    scene.find("board_4x4").style.background_image =~ /dim/
    scene.find("board_4x4").mouse_clicked(nil)
    scene.find("board_4x4").style.background_image.should_not =~ /dim/
    scene.find("board_3x3").style.background_image =~ /dim/
  end
end