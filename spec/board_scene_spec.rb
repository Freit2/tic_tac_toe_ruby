require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe "Board" do

  uses_limelight :scene => "board", :hidden => true

  it "should have three rows" do
    scene.children.size.should == 3
  end

  it "should have nine squares" do
    scene.children.each do |p|
      p.children.size.should == 3
    end
  end

  it "should have squares with ids from 0-8" do
    id = 0
    scene.children.each do |p|
      p.children.each do |s|
        s.id.should == id.to_s
        id += 1
      end
    end
  end

  it "should " do

  end
end
