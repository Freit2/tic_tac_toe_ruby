require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Square Players" do

  uses_scene "default_scene", :hidden => true

  before do
    scene.board = Board.new
    (0...scene.board.size).each do |s|
      instance_eval("scene.square_#{s}.casted")
    end
    @human = mock('human')
  end

  it "should start with disabled squares" do
    (0...scene.board.size).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == false
      instance_eval("scene.square_#{s}.hover_style").should == nil
      instance_eval("scene.square_#{s}.style.text_color").should == '#808080ff'
    end
  end

  it "should enable squares on new game" do
    scene.enable_squares
    (0...scene.board.size).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == true
      instance_eval("scene.square_#{s}.hover_style").should_not == nil
    end
  end

  it "should disable squares at the end of game" do
    scene.disable_squares
    (0...scene.board.size).each do |s|
      instance_eval("scene.square_#{s}.enabled").should == false
      instance_eval("scene.square_#{s}.hover_style").should == nil
      instance_eval("scene.square_#{s}.style.text_color").should == '#808080ff'
    end
  end

  it "should animate" do
    scene.square_0.should_receive(:animate)
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.square_0.animate_move
  end

  it "should still be running animation" do
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.square_0.animate_move
    scene.square_0.animation.running?.should == true
  end

  it "should stop animation within 1 second" do
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.square_0.animate_move
    sleep(1)
    scene.square_0.animation.running?.should == false
  end

  it "should have transparency at zero" do
    @human.should_receive(:piece).twice.and_return('O')
    scene.current_player = @human
    scene.square_0.animate_move
    sleep(1)
    scene.square_0.style.transparency.to_i.should == 0
  end

  it "should move piece to board" do
    scene.enable_squares
    scene.player_allowed = true
    scene.square_0.mouse_clicked(nil)
    scene.move.should == 0
  end

  it "should not allow user to place move if not her turn" do
    scene.enable_squares
    scene.player_allowed = false
    scene.square_0.mouse_clicked(nil)
    scene.move.should == nil
  end

  it "should not allow user to place move if space is occupied" do
    scene.square_0.text = 'O'
    
    scene.enable_squares
    scene.player_allowed = true
    scene.square_0.mouse_clicked(nil)
    scene.move.should == nil
  end

  it "should show player's piece hovered over empty space transparently"
end