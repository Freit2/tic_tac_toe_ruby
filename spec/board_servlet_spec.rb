require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'board_servlet'
require 'ttt'
include TTT

describe BoardServlet do
  before(:each) do
    @server = mock("WEBrick::HTTPServer")
    @server.should_receive(:[])
    load_libraries
    initialize_cache
    @board_servlet = BoardServlet.new(@server, @cache)
    @request = {}
    @request['board'] = '3x3'
    @request['player_o'] = 'human'
    @request['player_x'] = 'unbeatable'
  end

  it "should create board" do
    @board_servlet.create_board(@request['board'])
    @board_servlet.board.class.should == Board
    @board_servlet.board.size.should == 9
  end

  it "should create players" do
    @board_servlet.create_players(@request)
    @board_servlet.player_o.class.should == HumanPlayer
    @board_servlet.player_x.class.should == NegamaxPlayer
  end

  it "should add UI to players" do
    @board_servlet.create_players(@request)
    @board_servlet.player_o.ui.class.should == BoardServlet
    @board_servlet.player_x.ui.class.should == BoardServlet
  end

  it "should add cache to players" do
    @board_servlet.create_players(@request)
    @board_servlet.player_o.cache.class.should == HashCache
    @board_servlet.player_x.cache.class.should == HashCache
  end

  it "display board"
  it "start game thread"
end