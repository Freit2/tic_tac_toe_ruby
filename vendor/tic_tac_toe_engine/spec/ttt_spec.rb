require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"

describe TicTacToeEngine::TTT::Config do
  before(:all) do
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:active] = true
    TicTacToeEngine::TTT::CONFIG.boards['3x3'][:cache] = :hash
    TicTacToeEngine::TTT::CONFIG.boards['4x4'][:cache] = :mongo
  end

  before(:each) do
    @config = TicTacToeEngine::TTT::Config.new
    @hash = {:a => 1, :b => 2}
  end

  it "should initialize data ivar to an empty hash" do
    @config.data.should == {}
  end

  it "should add key/value pairs to data hash" do
    config = TicTacToeEngine::TTT::Config.new(@hash)
    config.data.should == @hash
  end

  it "should add key/value pairs" do
    @config.update!(@hash)
    @config.data.should == @hash
  end

  it "should update existing key/value pairs" do
    hash = {:a => 10, :b => 20}
    config = TicTacToeEngine::TTT::Config.new(@hash)
    config.update!(hash)
    config.data.should == hash
  end

  it "should add/update key/value pairs" do
    hash = {:b => 20, :c => "Hello World"}
    config = TicTacToeEngine::TTT::Config.new(@hash)
    config.update!(hash)
    config.data.should == {:a => 1, :b => 20, :c => "Hello World"}
  end

  it "should be an instance of Config" do
    TicTacToeEngine::TTT::CONFIG.class.should == TicTacToeEngine::TTT::Config
  end

  it "should return keys of Config" do
    config = TicTacToeEngine::TTT::Config.new(@hash)
    config.keys.should == [:a, :b]
  end

  it "should return values of Config" do
    config = TicTacToeEngine::TTT::Config.new(@hash)
    config.values.should == [1, 2]
  end

  it "should return key of value of Config" do
    config = TicTacToeEngine::TTT::Config.new(@hash)
    config.index(2).should == :b
  end

  it "should return active keys" do
    hash = { '3x3' => { :active => true }, '4x4' => { :active => false }}
    config = TicTacToeEngine::TTT::Config.new
    config.boards = hash
    config.boards.active.should == ['3x3']
  end
end
