require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'board'

describe "Square Players" do

  uses_scene "default_scene", :hidden => true

  before do
    scene.board = Board.new
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").casted
    end
    @human = mock('human')
  end

  it "should start with disabled squares" do
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").enabled.should == false
      scene.find("square_#{s}").hover_style.should == nil
      scene.find("square_#{s}").style.text_color.should == '#808080ff'
    end
  end

  it "should enable squares on new game" do
    scene.enable_squares
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").enabled.should == true
      scene.find("square_#{s}").hover_style.should_not == nil
    end
  end

  it "should disable squares at the end of game" do
    scene.disable_squares
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").enabled.should == false
      scene.find("square_#{s}").hover_style.should == nil
      scene.find("square_#{s}").style.text_color.should == '#808080ff'
    end
  end

  it "should animate" do
    scene.find("square_0").should_receive(:animate)
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.find("square_0").animate_move
  end

  it "should still be running animation" do
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.find("square_0").animate_move
    scene.find("square_0").animation.running?.should == true
  end

  it "should stop animation within 1 second" do
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.find("square_0").animate_move
    sleep(1)
    scene.find("square_0").animation.running?.should == false
  end

  it "should have transparency at zero" do
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.find("square_0").animate_move
    sleep(1)
    scene.find("square_0").style.transparency.to_i.should == 0
  end

  it "should move piece to board" do
    scene.enable_squares
    scene.player_allowed = true
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
    square.text.should == 'O'
    square.style.transparency.should == '81%'
  end

  it "should not hover player's piece when mouse exited" do
    scene.enable_squares
    scene.player_allowed = true
    @human.should_receive(:piece).twice.and_return('O')
    scene.should_receive(:current_player).twice.and_return(@human)
    square = scene.find("square_0")
    square.mouse_entered(nil)
    square.mouse_exited(nil)
    square.text.should_not == 'O'
    square.style.transparency.should == '0%'
  end
end