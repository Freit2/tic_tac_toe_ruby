require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe TicTacToeEngine::HashCache do
  let(:hash_cache) { TicTacToeEngine::HashCache.new }

  it "creates an empty hash collection" do
    hash_cache.collection.class.should == Array
    hash_cache.collection.size.should == 0
  end

  it "returns score for specific board and piece" do
    hash = {"board" => "XOXOXO",
      "piece" => "X", "score" => 1}
    hash_cache.collection << hash

    hash_cache.score("XOXOXO", "X").should == 1
  end

  it "returns nil for board and piece not found in collection" do
    hash_cache.score("XOXOXO", "X").should == nil
  end

  it "inserts board, piece, score into collection" do
    hash = {"board" => "XOXOXO",
      "piece" => "X", "score" => 1}
    hash_cache.memoize("XOXOXO", "X", 1)

    hash_cache.collection.size.should == 1
    hash_cache.collection.first.should == hash
  end
end
