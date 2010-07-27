require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Button Players" do

  uses_scene "options_scene", :hidden => true

  before(:all) do
    production.production_opening
  end

  before(:each) do
    production.production_loaded
  end

  before do
    scene.start_button.casted
    scene.exit_button.casted
  end

  it "should start with enabled buttons" do
    scene.start_button.enabled.should == true
    scene.exit_button.enabled.should == true
  end
end