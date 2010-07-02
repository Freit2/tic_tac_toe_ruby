require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'game'
require 'board'
require 'human_player'
require 'easy_cpu_player'
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
    easy_cpu = scene.get_player('easy cpu', 'X')
    easy_cpu.class.name.should == 'EasyCpuPlayer'
    easy_cpu.piece.should == 'X'
    medium_cpu = scene.get_player('medium cpu', 'X')
    medium_cpu.class.name.should == 'CpuPlayer'
    medium_cpu.piece.should == 'X'
    unbeatable_cpu = scene.get_player('unbeatable cpu', 'O')
    unbeatable_cpu.class.name.should == 'MinMaxPlayer'
    unbeatable_cpu.piece.should == 'O'
  end

  it "should default to human and minmax players" do
    scene.player_o_type.text.should == 'human'
    scene.player_x_type.text.should == 'unbeatable cpu'
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

  it "should return correct piece color" do
    @h = mock('human')
    @c = mock('cpu')
    @h.should_receive(:piece).and_return('O')
    @c.should_receive(:piece).and_return('X')
    scene.current_player = @h
    scene.piece_color.should == :crimson
    scene.current_player = @c
    scene.piece_color.should == :royal_blue
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

  it "should clear squares" do
    scene.board = Board.new
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").text = 'X'
    end
    scene.clear_squares
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").text.strip.should == ''
    end
  end

  it "should close" do
    scene.stage.should_receive(:close)

    scene.close
  end
  
end