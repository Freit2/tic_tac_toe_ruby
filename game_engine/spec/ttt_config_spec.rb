require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe "config" do
  before(:all) do
    TTT::CONFIG.keys.include?(:boards).should == true
    TTT::CONFIG.keys.include?(:players).should == true
    TTT::CONFIG.keys.include?(:cache).should == true
    TTT::CONFIG.boards.keys.include?(:'3x3').should == true
    TTT::CONFIG.boards.keys.include?(:'4x4').should == true
    TTT::CONFIG.players.keys.include?(:human).should == true
    TTT::CONFIG.players.keys.include?(:easy).should == true
    TTT::CONFIG.players.keys.include?(:med).should == true
    TTT::CONFIG.players.keys.include?(:hard).should == true
  end

  before(:each) do
    TTT::CONFIG.boards['3x3'][:active] = true
    TTT::CONFIG.boards['4x4'][:active] = true
    TTT::CONFIG.boards['3x3'][:cache] = :hash
    TTT::CONFIG.boards['4x4'][:cache] = :mongo
  end

  it "should deactivate 4x4 if MongoDB is not found" do
    MongoCache.should_receive(:db_installed?).and_return(false)
    TTT.initialize_cache
    TTT::CONFIG.boards['4x4'][:active].should == false
  end

  it "should create an instance of MongoCache" do
    MongoCache.should_receive(:db_installed?).and_return(true)
    MongoCache.should_receive(:new).and_return(mongo_cache = mock("mongo_cache"))
    TTT.initialize_cache
    TTT::CONFIG.cache[:mongo].should equal(mongo_cache)
  end

  it "should create an instance of HashCache" do
    TTT.initialize_cache
    TTT::CONFIG.cache[:hash].class.should == HashCache
  end
end
