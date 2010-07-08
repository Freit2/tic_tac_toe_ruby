require File.expand_path(File.dirname(__FILE__) + "/spec_helper")
require 'game'
require 'board'
require 'player'

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

  it "should default to human and minmax players" do
    scene.player_o_type.text.should == 'human'
    scene.player_x_type.text.should == 'unbeatable cpu'
  end

  it "should create player instances" do
    scene.create_players

    scene.player_o.class.name.should == 'HumanPlayer'
    scene.player_x.class.name.should == 'NegamaxPlayer'
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

  it "should create a new Board instance on new game" do
    board = scene.board
    scene.play_new_game
    scene.board.should_not == board
  end

  it "should receive method calls on new game" do
    scene.should_receive(:clear_squares)
    scene.should_receive(:create_players)
    scene.should_receive(:enable_squares)
    scene.should_receive(:start_game_thread)
    scene.play_new_game
  end

  it "should create game on new thread" do
    Game.should_receive(:new).and_return(scene.game = mock("game"))
    scene.game.should_receive(:play)
    scene.start_game_thread
    sleep(0.1)
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

  it "should still be animating" do
    scene.board = Board.new
    scene.board.move(0, 'X')
    scene.board.move(1, 'X')
    scene.board.move(2, 'X')
    scene.board.game_over?
    scene.animate_win
    scene.animation.running?.should == true
  end
end
