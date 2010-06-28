require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Square Players" do

  uses_scene "default_scene", :hidden => true

  before do
    (0..8).each do |s|
      instance_eval("scene.square_#{s}.casted")
    end
  end

  it "should start with disabled squares" do
    (0..8).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == false
      instance_eval("scene.square_#{s}.hover_style").should == nil
      instance_eval("scene.square_#{s}.style.text_color").should == '#808080ff'
    end
  end

  it "should enable squares on new game" do
    scene.enable_squares
    (0..8).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == true
      instance_eval("scene.square_#{s}.hover_style").should_not == nil
    end
  end

  it "should disable squares at the end of game" do
    scene.disable_squares
    (0..8).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == false
      instance_eval("scene.square_#{s}.hover_style").should == nil
      instance_eval("scene.square_#{s}.style.text_color").should == '#808080ff'
    end
  end
  
end