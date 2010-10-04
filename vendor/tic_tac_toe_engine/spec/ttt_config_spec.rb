require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe "config" do
  before(:all) do
    TicTacToeEngine::TTT::CONFIG.keys.include?(:boards).should == true
    TicTacToeEngine::TTT::CONFIG.keys.include?(:players).should == true
    TicTacToeEngine::TTT::CONFIG.keys.include?(:cache).should == true
    TicTacToeEngine::TTT::CONFIG.boards.keys.include?(:'3x3').should == true
    TicTacToeEngine::TTT::CONFIG.boards.keys.include?(:'4x4').should == true
    TicTacToeEngine::TTT::CONFIG.players.keys.include?(:human).should == true
    TicTacToeEngine::TTT::CONFIG.players.keys.include?(:easy).should == true
    TicTacToeEngine::TTT::CONFIG.players.keys.include?(:med).should == true
    TicTacToeEngine::TTT::CONFIG.players.keys.include?(:hard).should == true
  end

  before(:each) do
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:cache] = :hash
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:cache] = :mongo
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
