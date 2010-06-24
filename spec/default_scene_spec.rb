require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Default Scene" do

  uses_scene "default_scene", :hidden => true

  it "should start" do
    scene.should_receive(:start)

    scene.start
  end

  it "should close" do
    scene.stage.should_receive(:close)

    scene.close
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

  it "should have three squares for each row" do
    scene.children.each do |p|
      if p.name == "row"
        p.children.size.should == 3
      end
    end
  end

  it "should have squares with ids from 0-8" do
    id = 0
    scene.children.each do |p|
      if p.name == "row"
        p.children.each do |s|
          s.id.should == "square_#{id}"
          id += 1
        end
      end
    end
  end
end