require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "MenuItem Players" do

  uses_scene "default_scene", :hidden => true

  before do
    scene.start_button.casted
    scene.exit_button.casted
  end

  it "should start with enabled menu items" do
    scene.start_button.enabled.should == true
    scene.exit_button.enabled.should == true
  end

  it "should disable new game button on new game" do
    scene.start_button.disable
    scene.start_button.enabled.should == false
    scene.start_button.hover_style.should == nil
    scene.start_button.style.text_color.should == '#808080ff'
  end

end