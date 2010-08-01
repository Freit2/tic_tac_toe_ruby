require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'nil_cache'

describe NilCache do
  let(:nil_cache) { NilCache.new }

  it "should return nil" do
    nil_cache.score("XOXOXO", "O").should == nil
  end

  it "should store nothing" do
    nil_cache.memoize("XOXOXO", "O", 1)
    nil_cache.score("XOXOXO", "O").should == nil
  end
end