require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'tic_tac_toe'
require 'game'
require 'human_player'
require 'cpu_player'
require 'std_ui'

describe TicTacToe do
  before(:all) do
    TTT::CONFIG.boards['3x3'][:active] = true
    TTT::CONFIG.boards['4x4'][:active] = true
    TTT::CONFIG.boards['3x3'][:cache] = :hash
    TTT::CONFIG.boards['4x4'][:cache] = :mongo
  end

  after(:each) do
    TTT::CONFIG.boards['3x3'][:active] = true
    TTT::CONFIG.boards['4x4'][:active] = true
  end

  before(:each) do
    @input = StringIO.new
    @output = StringIO.new
    @ui = StdUI.new(@input, @output)
    @ttt = TicTacToe.new(@ui)
    @ttt.initialize_cache
  end
  
  it "should be able to create a new instance" do
    lambda { TicTacToe.new }.should_not raise_error
  end

  it "should return player" do
    @ttt.ui.input.string = "h"
    @ttt.get_player('O').instance_of?(HumanPlayer)
    @ttt.ui.input.string = "e"
    @ttt.get_player('X').instance_of?(EasyCpuPlayer)
    @ttt.ui.input.string = "m"
    @ttt.get_player('X').instance_of?(CpuPlayer)
    @ttt.ui.input.string = "u"
    @ttt.get_player('X').instance_of?(NegamaxPlayer)
  end

  it "should create players" do
    @ttt.ui.input.string = "h\nu"
    @ttt.board_selection = '3x3'
    @ttt.create_players

    @ttt.player_o.ui.should equal(@ui)
    @ttt.player_x.ui.should equal(@ui)
  end

  it "should get board" do
    @ttt.ui.input.string = "1\n2\n3\n4"
    board = @ttt.get_board
    board.size.should == 9

    @ttt.ui.input.string = "a\nb\n4\n3"
    board_2 = @ttt.get_board
    board_2.size.should == 16
  end

  it "should play game" do
    @ttt.should_receive(:create_players)
    @ttt.should_receive(:get_board).and_return(@ttt.board = mock("board"))
    Game.should_receive(:new).and_return(@ttt.game = mock("game"))
    @ttt.game.should_receive(:play)
    @ttt.should_receive(:play_again?).and_return(false)
    @ttt.ui.should_receive(:display_exit_message)
    @ttt.play
  end

  it "should get play again" do
    @ttt.ui.input.string = "a\nb\ny"
    @ttt.play_again?.should == true

    @ttt.ui.input.string = "a\nb\nn"
    @ttt.play_again?.should == false
  end

  it "should deactivate 4x4 if MongoDB is not found" do
    MongoCache.should_receive(:db_installed?).and_return(false)
    @ttt.initialize_cache
    TTT::CONFIG.boards['4x4'][:active].should == false
  end

  it "should create an instance of MongoCache" do
    MongoCache.should_receive(:db_installed?).and_return(true)
    MongoCache.should_receive(:new).and_return(mongo_cache = mock("mongo_cache"))
    @ttt.initialize_cache
    @ttt.cache[:mongo].should equal(mongo_cache)
  end

  it "should create an instance of HashCache" do
    @ttt.initialize_cache
    @ttt.cache[:hash].class.should == HashCache
  end
end
