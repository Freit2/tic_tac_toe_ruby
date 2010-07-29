require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'board'

describe "Square Players" do

  uses_scene "board_scene", :hidden => true

  before(:all) do
    production.production_opening
  end

  before(:each) do
    production.production_loaded
    scene.remove_squares
    scene.create_board
    scene.build_squares
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").casted
    end
    @human = mock('human')
  end

  it "should animate" do
    @human.should_receive(:piece).and_return('O')
    scene.should_receive(:current_player).and_return(@human)
    scene.find("square_0").animate_move
    scene.find("square_0").style.background_image.should =~ /o\.jpg/
  end

  it "should move piece to board" do
    scene.enable_squares
    scene.player_allowed = true
    @human.should_receive(:piece).and_return('O')
    scene.should_receive(:current_player).and_return(@human)
    scene.find("square_0").mouse_entered(nil)
    scene.find("square_0").mouse_clicked(nil)
    scene.move.should == 0
  end

  it "should not allow user to place move if not her turn" do
    scene.enable_squares
    scene.player_allowed = false
    scene.find("square_0").mouse_clicked(nil)
    scene.move.should == nil
  end

  it "should not allow user to place move if space is occupied" do
    scene.find("square_0").text = 'O'
    
    scene.enable_squares
    scene.player_allowed = true
    scene.find("square_0").mouse_clicked(nil)
    scene.move.should == nil
  end

  it "should show player's piece hovered over empty space transparently" do
    scene.enable_squares
    scene.player_allowed = true
    @human.should_receive(:piece).twice.and_return('O')
    scene.should_receive(:current_player).twice.and_return(@human)
    square = scene.find("square_0")
    square.mouse_entered(nil)
    scene.find("square_0").style.background_image.should =~ /o_dim\.jpg/

    square.mouse_exited(nil)
    square.mouse_moved(nil)
    scene.find("square_0").style.background_image.should =~ /o_dim\.jpg/
  end

  it "should not hover player's piece when mouse exited" do
    scene.enable_squares
    scene.player_allowed = true
    @human.should_receive(:piece).and_return('O')
    scene.should_receive(:current_player).and_return(@human)
    square = scene.find("square_0")
    square.mouse_entered(nil)
    square.mouse_exited(nil)
    scene.find("square_0").style.background_image.should_not =~ /o_dim\.jpg/
  end
end