require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Production" do

  uses_scene "game_scene", :hidden => true, :stage => "options"

  before(:all) do
    production.production_opening
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:cache] = :hash
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:cache] = :mongo
  end

  after(:each) do
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:active] = true
  end

  it "should load require libraries" do
    TicTacToeEngine::TTT::Config.should_receive(:new)
    TicTacToeEngine::HashCache.should_receive(:new)
    TicTacToeEngine::MongoCache.should_receive(:new)
    TicTacToeEngine::Game.should_receive(:new)
    TicTacToeEngine::Board.should_receive(:new)
    TicTacToeEngine::Player.should_receive(:create)
    
    TicTacToeEngine::TTT::Config.new
    TicTacToeEngine::HashCache.new
    TicTacToeEngine::MongoCache.new
    TicTacToeEngine::Game.new("o", "x", "board", "ui")
    TicTacToeEngine::Board.new
    TicTacToeEngine::Player.create('H', 'O')
  end

  it "should have instance variables" do
    production.production_loaded
    production.scoreboard.class.should == TicTacToeEngine::Scoreboard
    production.board_selection.should == "3x3"
    production.player_selection.first[:value].should == "human"
    production.player_selection.last[:value].should == "unbeatable"
  end

  it "should call TTT.initialize_cache" do
    TicTacToeEngine::TTT.should_receive(:initialize_cache)
    production.production_loaded
  end

  it "should close production if there are no active boards" do
    production.should_receive(:puts)
    production.should_receive(:close)
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:active] = false
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:active] = false

    production.production_loaded
  end

  it "should deactivate 4x4 if MongoDB is not found" do
    TicTacToeEngine::MongoCache.should_receive(:db_installed?).and_return(false)
    TicTacToeEngine::TTT.initialize_cache
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:active].should == false
  end

  it "should create an instance of MongoCache" do
    TicTacToeEngine::MongoCache.should_receive(:db_installed?).and_return(true)
    TicTacToeEngine::MongoCache.should_receive(:new).and_return(mongo_cache = mock("mongo_cache"))
    TicTacToeEngine::TTT.initialize_cache
    TicTacToeEngine::TTT::CONFIG.cache[:mongo].should equal(mongo_cache)
  end

  it "should create an instance of HashCache" do
    TicTacToeEngine::TTT.initialize_cache
    TicTacToeEngine::TTT::CONFIG.cache[:hash].class.should == TicTacToeEngine::HashCache
  end
end
