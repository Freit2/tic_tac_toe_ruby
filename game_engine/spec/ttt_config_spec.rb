require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

class MockTTT
  include TTT
end

describe "config" do
  before(:each) do
    TTT::CONFIG.boards['3x3'][:active] = true
    TTT::CONFIG.boards['4x4'][:active] = true
    TTT::CONFIG.boards['3x3'][:cache] = :hash
    TTT::CONFIG.boards['4x4'][:cache] = :mongo
    @mock_ttt = MockTTT.new
  end

  it "should deactivate 4x4 if MongoDB is not found" do
    MongoCache.should_receive(:db_installed?).and_return(false)
    @mock_ttt.initialize_cache
    TTT::CONFIG.boards['4x4'][:active].should == false
  end

  it "should create an instance of MongoCache" do
    MongoCache.should_receive(:db_installed?).and_return(true)
    MongoCache.should_receive(:new).and_return(mongo_cache = mock("mongo_cache"))
    @mock_ttt.initialize_cache
    TTT::CONFIG.cache[:mongo].should equal(mongo_cache)
  end

  it "should create an instance of HashCache" do
    @mock_ttt.initialize_cache
    TTT::CONFIG.cache[:hash].class.should == HashCache
  end
end
