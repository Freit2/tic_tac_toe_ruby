require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe MongoCache do
  let(:mongo_cache) { MongoCache.new }

  it "returns false if MongoDB is not installed" do
    Mongo::Connection.should_receive(:new).and_raise(Mongo::ConnectionFailure)
    
    MongoCache.db_installed?.should == false
  end

  it "returns true if MongoDB is installed" do
    Mongo::Connection.should_receive(:new)

    MongoCache.db_installed?.should == true
  end

  it "creates a collection instance to db 'ttt', collection 'boards'" do
    mongo_cache.collection.class.should == Mongo::Collection
  end

  it "returns score for specific board and piece" do
    mongo_cache.collection.should_receive(:find_one).and_return(bson = mock("bson"))
    bson.should_receive(:[]).and_return(1)

    mongo_cache.score("OXOXOX", "O").should == 1
  end

  it "returns nil for board and piece not found in db" do
    mongo_cache.collection.should_receive(:find_one).and_return(nil)

    mongo_cache.score("OXOXOX", "X").should == nil
  end

  it "inserts board, piece, score into db" do
    mongo_cache.collection.should_receive(:insert)

    mongo_cache.memoize("OXOXOX", "X", 1)
  end
end