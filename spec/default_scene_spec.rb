require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'game'
require 'board'
require 'human_player'
require 'cpu_player'
require 'min_max_player'

describe "Default Scene" do

  uses_scene "default_scene", :hidden => true

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

  it "should return specific player" do
    human = scene.get_player('human', 'O')
    human.class.name.should == 'HumanPlayer'
    human.piece.should == 'O'
    cpu = scene.get_player('cpu', 'X')
    cpu.class.name.should == 'CpuPlayer'
    cpu.piece.should == 'X'
    minmax = scene.get_player('minmax', 'O')
    minmax.class.name.should == 'MinMaxPlayer'
    minmax.piece.should == 'O'
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

  it "should have player hold default_scene UI" do
    scene.create_players
    
    scene.player_o.ui.should == scene
    scene.player_x.ui.should == scene
  end

  it "should display board" do
    board = Board.new(['X','X','X','X','X','O','O','O','O'])
    scene.display_board(board)
    scene.square_0.text.should == 'X'
    scene.square_1.text.should == 'X'
    scene.square_2.text.should == 'X'
    scene.square_3.text.should == 'X'
    scene.square_4.text.should == 'X'
    scene.square_5.text.should == 'O'
    scene.square_6.text.should == 'O'
    scene.square_7.text.should == 'O'
    scene.square_8.text.should == 'O'
  end

  it "should play new game" do
    scene.should_receive(:play_new_game)

    scene.play_new_game
  end

  it "should enable new game button on try again" do
    scene.start_button.disable
    scene.display_try_again
    scene.start_button.enabled.should == true
  end

  it "should close" do
    scene.stage.should_receive(:close)

    scene.close
  end
  
end