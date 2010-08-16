require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'board_servlet'
include TTT

class MockRequest
  attr_accessor :query, :request_method
  def initialize
    @query = {}
    @request_method = "mock"
  end
end

class MockResponse
  attr_accessor :status, :body
  def initialize
    @hash = {}
  end
  def []=(key, value)
  end
end

describe BoardServlet do
  before(:each) do
    @server = mock("WEBrick::HTTPServer")
    @server.should_receive(:[])
    initialize_cache
    @board_servlet = BoardServlet.new(@server, TTT::CONFIG.cache)
    @request = {}
    @request[:board] = '3x3'
    @request[:player_o] = 'human'
    @request[:player_x] = 'unbeatable'
    @board_servlet.request = @request
    @response = MockResponse.new
    @x = 'X'
    @o = 'O'
  end

  it "should set defaults" do
    @board_servlet.cache.should == TTT::CONFIG.cache
    @board_servlet.template.should == "board_template.rhtml"
    @board_servlet.title.should == "WEBrick Tic Tac Toe!"
  end

  it "should create board" do
    @board_servlet.create_board
    @board_servlet.board.class.should == Board
    @board_servlet.board.size.should == 9
  end

  it "should create players" do
    @board_servlet.create_players
    @board_servlet.player_o.class.should == HumanPlayer
    @board_servlet.player_x.class.should == NegamaxPlayer
  end

  it "should add UI to players" do
    @board_servlet.create_players
    @board_servlet.player_o.ui.class.should == BoardServlet
    @board_servlet.player_x.ui.class.should == BoardServlet
  end

  it "should add cache to players" do
    @board_servlet.create_players
    @board_servlet.player_o.cache.class.should == HashCache
    @board_servlet.player_x.cache.class.should == HashCache
  end

  it "should generate quit html" do
    @board_servlet.generate_quit_html.should ==
      "<form method='GET' action='/'>" +
      "<input type=\"submit\" value=\"Return to Options\" />" +
      "</form>"
  end

  it "should generate status html" do
    @board_servlet.status = "Hello World"
    @board_servlet.generate_status_html.should ==
      "<img src=\"Hello World\" alt=\"status\" width=\"502\" height=\"75\"/>"

    @board_servlet.status = nil
    @board_servlet.generate_status_html.should == ""
  end

  it "should generate row html" do
    array = [].fill(0, 9) { " " }
    array[0] = 'X'
    array[1] = 'O'
    @board_servlet.board = Board.new(array)
    
    @board_servlet.generate_row_html(0).should ==
      "<img border=\"1\" src=\"/images/pieces/x.png\" " +
      "alt=\"square\" width=\"130\" height=\"130\"  />"

    @board_servlet.generate_row_html(1).should ==
      "<img border=\"1\" src=\"/images/pieces/o.png\" " +
      "alt=\"square\" width=\"130\" height=\"130\"  />"

    @board_servlet.generate_row_html(2).should ==
      "<a href=\"/new?s=2\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" " +
      "alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" " +
      "onmouseout=\"TTT.mouseOutSquare(this)\"/></a>"
  end

  it "should generate board html" do
    array = [].fill(0, 9) { " " }
    @board_servlet.board = Board.new(array)
    mock_row_html = "mock_row_html"
    @board_servlet.should_receive(:generate_row_html).exactly(9).and_return(mock_row_html)

    board_html = ""
    3.times do
      3.times do
        board_html += mock_row_html
      end
      board_html += "<br />"
    end

    @board_servlet.generate_board_html.should == board_html
  end

  it "should create an eRB from rhtml" do
    File.should_receive(:expand_path).and_return(mocked_file_path = "file_path")
    rhtml_file = "#{mocked_file_path}/rhtml/#{@board_servlet.template}"
    IO.should_receive(:read).with(rhtml_file).and_return(mocked_file_string = "file_string")
    ERB.should_receive(:new).with(mocked_file_string).and_return(mocked_erb = mock("ERB"))
    @board_servlet.convert(@board_servlet.template).should == mocked_erb
  end

  it "should generate body" do
    @board_servlet.should_receive(:convert).and_return(mocked_erb = mock("ERB"))
    mocked_erb.should_receive(:result)
    @board_servlet.generate_body
  end

  it "should create game on new thread" do
    Game.should_receive(:new).and_return(@board_servlet.game = mock("game"))
    @board_servlet.game.should_receive(:scoreboard=)
    @board_servlet.game.should_receive(:play)
    @board_servlet.should_receive(:wait_until_game_starts)
    @board_servlet.start_game_thread
    @board_servlet.thread.join
  end

  it "should set @move to user clicked square when player allowed" do
    @board_servlet.should_receive(:wait_until_move_is_made)
    @board_servlet.should_receive(:generate_body)
    request = MockRequest.new
    request.query['s'] = 3
    @board_servlet.player_allowed = true
    @board_servlet.do_GET(request, @response)

    @board_servlet.move.should == 3
  end

  it "should not set @move to user clicked square when player not allowed" do
    @board_servlet.should_receive(:generate_body)
    request = MockRequest.new
    request.query['s'] = 5
    @board_servlet.player_allowed = false
    @board_servlet.do_GET(request, @response)

    @board_servlet.move.should == nil
  end

  it "should receive message for do_POST" do
    @board_servlet.should_receive(:create_board)
    @board_servlet.should_receive(:create_players)
    @board_servlet.should_receive(:start_game_thread)
    @board_servlet.should_receive(:generate_body)

    @board_servlet.do_POST(MockRequest.new, @response)
  end

  it "should wait until game starts" do
    @board_servlet.current_player = mock("current_player")
    @board_servlet.should_not_receive(:sleep)
    @board_servlet.wait_until_game_starts
  end

#  it "should wait until move" do
#    @board_servlet.player_allowed.should == false
#    move = nil
#    thread = Thread.new do
#      move = @board_servlet.wait_for_move
#    end
#    while !@board_servlet.move
#      @board_servlet.move = 8
#    end
#    thread.join
#    @board_servlet.player_allowed.should == false
#    @board_servlet.move.should == move
#  end

  it "should display message" do
    status = mock("status")
    @board_servlet.display_message(status)
    @board_servlet.status.should == status
  end

  it "should display cpu move message" do
    piece = "O"
    @board_servlet.should_receive(:display_message).with("/images/messages/player_#{piece.downcase}_moves.png")
    @board_servlet.display_cpu_move_message(piece)
  end

  it "should display winner" do
    winner = "X"
    @board_servlet.should_receive(:display_message).with("/images/end_message/winner_#{winner.downcase}.png")
    @board_servlet.display_winner(winner)
  end

  it "should display draw" do
    @board_servlet.should_receive(:display_message).with("/images/end_message/draw_game.png")
    @board_servlet.display_draw_message
  end
end
