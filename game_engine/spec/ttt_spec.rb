require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe TTT::Config do
  before(:each) do
    @config = TTT::Config.new
    @hash = {:a => 1, :b => 2}
  end

  it "should initialize data ivar to an empty hash" do
    @config.data.should == {}
  end

  it "should add key/value pairs to data hash" do
    config = TTT::Config.new(@hash)
    config.data.should == @hash
  end

  it "should add key/value pairs" do
    @config.update!(@hash)
    @config.data.should == @hash
  end

  it "should update existing key/value pairs" do
    hash = {:a => 10, :b => 20}
    config = TTT::Config.new(@hash)
    config.update!(hash)
    config.data.should == hash
  end

  it "should add/update key/value pairs" do
    hash = {:b => 20, :c => "Hello World"}
    config = TTT::Config.new(@hash)
    config.update!(hash)
    config.data.should == {:a => 1, :b => 20, :c => "Hello World"}
  end

  it "should be an instance of Config" do
    TTT::CONFIG.class.should == TTT::Config
  end

  it "should return keys of Config" do
    config = TTT::Config.new(@hash)
    config.keys.should == [:a, :b]
  end

  it "should return values of Config" do
    config = TTT::Config.new(@hash)
    config.values.should == [1, 2]
  end

  it "should return key of value of Config" do
    config = TTT::Config.new(@hash)
    config.index(2).should == :b
  end

  it "should return active keys" do
    hash = { '3x3' => { :active => true }, '4x4' => { :active => false }}
    config = TTT::Config.new
    config.boards = hash
    config.boards.active.should == ['3x3']
  end
end