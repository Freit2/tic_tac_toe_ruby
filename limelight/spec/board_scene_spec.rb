require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Board Scene" do

  uses_scene "board_scene", :hidden => true

  before(:all) do
    production.production_opening
  end

  before(:each) do
    production.production_loaded
  end

  it "should create default board" do
    scene.create_board
    scene.build_squares

    id = 0
    count = 0
    scene.children.each do |p|
      if p.name == "row"
        count += 1
        p.children.size.should == 3
        p.children.each do |s|
          s.id.should == "square_#{id}"
          id += 1
        end
      end
    end
    count.should == 3
  end

  it "should create 4x4 board" do
    production.board_selection = '4x4'
    scene.create_board
    scene.build_squares

    id = 0
    count = 0
    scene.children.each do |p|
      if p.name == "row"
        count += 1
        p.children.size.should == 4
        p.children.each do |s|
          s.id.should == "square_#{id}"
          id += 1
        end
      end
    end
    count.should == 4
  end

  it "should create try again" do
    scene.build_try_again

    count = 0
    scene.children.each do |p|
      if p.name == "try_again_menu"
        count += 1
        p.children.size.should == 3
      end
    end
    count.should == 1
  end

  it "should create view scoreboard" do
    scene.build_view_scoreboard

    count = 0
    scene.children.each do |p|
      if p.name == "view_scoreboard_menu"
        count += 1
        p.children.size.should == 2
      end
    end
    count.should == 1
  end

  it "should remove board from scene" do
    scene.create_board
    scene.build_squares

    scene.children.size.should == 7

    scene.remove_squares

    scene.children.size.should == 4
  end

  it "should remove try again from scene" do
    scene.build_try_again

    scene.children.size.should == 5
    
    scene.remove_try_again

    scene.children.size.should == 4
  end

  it "should remove scoreboard from scene" do
    scene.build_view_scoreboard

    scene.children.size.should == 5

    scene.remove_view_scoreboard

    scene.children.size.should == 4
  end

  it "should create player instances" do
    scene.create_players

    scene.player_o.class.name.should == 'HumanPlayer'
    scene.player_x.class.name.should == 'NegamaxPlayer'
  end

  it "should have player hold board_scene UI" do
    scene.create_players
    
    scene.player_o.ui.should equal(scene)
    scene.player_x.ui.should equal(scene)
  end

  it "should create a new Board instance on new game" do
    board = scene.board
    production.board_selection = '4x4'
    scene.remove_squares
    scene.create_board
    scene.build_squares
    scene.board.should_not == board
  end

  it "should receive method calls on start" do
    scene.should_receive(:create_board)
    scene.should_receive(:build_squares)
    scene.should_receive(:format_squares)
    scene.should_receive(:clear_squares)
    scene.should_receive(:create_players)
    scene.should_receive(:enable_squares)
    scene.should_receive(:start_game_thread)
    scene.start
  end

  it "should receive method calls on cleanup" do
    scene.should_receive(:remove_squares)
    scene.should_receive(:remove_try_again)
    scene.should_receive(:remove_view_scoreboard)
    scene.cleanup
  end

  it "should receive method calls on restart" do
    scene.should_receive(:cleanup)
    scene.should_receive(:start)
    scene.restart
  end

  it "should create game on new thread" do
    Game.should_receive(:new).and_return(scene.game = mock("game"))
    scene.game.should_receive(:scoreboard=)
    scene.game.should_receive(:play)
    scene.start_game_thread
    scene.thread.join
  end

  it "should clear squares" do
    scene.create_board
    scene.build_squares

    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").text = 'X'
    end
    scene.clear_squares
    
    (0...scene.board.size).each do |s|
      scene.find("square_#{s}").text.strip.should == ''
    end
  end

  it "should still be animating" do
    scene.board = Board.new
    scene.build_squares
    scene.board.move(0, 'X')
    scene.board.move(1, 'X')
    scene.board.move(2, 'X')
    scene.board.game_over?
    scene.animate_win
    
    scene.animation.running?.should == true
  end

  it "should receive method calls on open_options" do
    scene.should_receive(:cleanup)
    scene.should_receive(:open_options_scene)
    scene.stage.should_receive(:hide)

    scene.open_options
  end

  it "should receive method calls on open_scoreboard" do
    scene.should_receive(:open_scoreboard_scene)
    scene.stage.should_receive(:hide)

    scene.open_scoreboard
  end

  it "should receive messages" do
    scene.should_receive(:build_view_scoreboard)
    scene.display_scores(nil)

    scene.should_receive(:build_try_again)
    scene.display_try_again
  end
end
