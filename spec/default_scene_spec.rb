require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'game'
require 'board'
require 'human_player'
require 'cpu_player'
require 'min_max_player'

describe "Default Scene" do

  uses_scene "default_scene", :hidden => true

  before do
    #scene.player.casted
    #scene.player_selection.casted
  end

  it "should play new game" do
    scene.should_receive(:play_new_game)

    scene.play_new_game
  end

  it "should close" do
    scene.stage.should_receive(:close)

    scene.close
  end

  it "should have a status prop" do
    count = 0
    scene.children.each do |p|
      if p.name == "status"
        count += 1
      end
    end

    count.should == 1
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

  it "should have a blank status text" do
    scene.status.text == ""
  end

  it "should display status message" do
    scene.display_message('test message')
    scene.status.text.should == 'test message'
  end

  it "should default to human and minmax players" do
    scene.player_o_type.text.should == 'human'
    scene.player_x_type.text.should == 'minmax'
  end

  it "should create player instances" do
    scene.create_players

    scene.player_o.class.name.should == 'HumanPlayer'
    scene.player_x.class.name.should == 'MinMaxPlayer'
  end

  it "should start with enabled menu items" do
    scene.start_button.enabled.should == true
    scene.exit_button.enabled.should == true
  end

  it "should start with disabled squares" do
    (0..8).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == false
      instance_eval("scene.square_#{s}.hover_style").should == nil
      instance_eval("scene.square_#{s}.style.text_color").should == '#808080ff'
    end
  end

  it "should disable start button on new game" do
    scene.start_button.disable
    scene.start_button.enabled.should == false
    scene.start_button.hover_style.should == nil
    scene.start_button.style.text_color.should == '#808080ff'
  end

  it "should enable squares on new game" do
    scene.enable_squares
    (0..8).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == true
      instance_eval("scene.square_#{s}.hover_style").should_not == nil
    end
  end

end