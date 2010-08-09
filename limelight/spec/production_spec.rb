require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Production" do

  uses_scene "game_scene", :hidden => true, :stage => "options"

  before(:all) do
    production.production_opening
    TTT::CONFIG.boards['3x3'][:active] = true
    TTT::CONFIG.boards['4x4'][:active] = true
    TTT::CONFIG.boards['3x3'][:cache] = :hash
    TTT::CONFIG.boards['4x4'][:cache] = :mongo
  end

  after(:each) do
    TTT::CONFIG.boards['3x3'][:active] = true
    TTT::CONFIG.boards['4x4'][:active] = true
  end

  it "should load require libraries" do
    TTT::Config.should_receive(:new)
    HashCache.should_receive(:new)
    MongoCache.should_receive(:new)
    Game.should_receive(:new)
    Board.should_receive(:new)
    Player.should_receive(:create)
    
    TTT::Config.new
    HashCache.new
    MongoCache.new
    Game.new("o", "x", "board", "ui")
    Board.new
    Player.create('H', 'O')
  end

  it "should have instance variables" do
    production.production_loaded
    production.scoreboard.class.should == Scoreboard
    production.board_selection.should == "3x3"
    production.player_selection.first[:value].should == "human"
    production.player_selection.last[:value].should == "unbeatable"
  end

  it "should call production.initialize_cache" do
    production.should_receive(:initialize_cache)
    production.production_loaded
  end

  it "should close production if there are no active boards" do
    production.should_receive(:puts)
    production.should_receive(:close)
    TTT::CONFIG.boards['3x3'][:active] = false
    TTT::CONFIG.boards['4x4'][:active] = false

    production.production_loaded
  end

  it "should deactivate 4x4 if MongoDB is not found" do
    MongoCache.should_receive(:db_installed?).and_return(false)
    production.initialize_cache
    TTT::CONFIG.boards['4x4'][:active].should == false
  end

  it "should create an instance of MongoCache" do
    MongoCache.should_receive(:db_installed?).and_return(true)
    MongoCache.should_receive(:new).and_return(mongo_cache = mock("mongo_cache"))
    production.initialize_cache
    TTT::CONFIG.cache[:mongo].should equal(mongo_cache)
  end

  it "should create an instance of HashCache" do
    production.initialize_cache
    TTT::CONFIG.cache[:hash].class.should == HashCache
  end
end
