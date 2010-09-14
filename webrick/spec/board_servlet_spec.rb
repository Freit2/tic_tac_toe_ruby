require File.expand_path(File.dirname(__FILE__)) + "/spec_helper"
require 'board_servlet'

def cookie(response, name)
  cookie = response.cookies.find {|c| c.name == name}
  return cookie.nil? ? nil : cookie.value
end

def new_get_request(params)
  request = WEBrick::HTTPRequest.new({})
  request.cookies << WEBrick::Cookie.new("board_state", params[:board_state])
  request.cookies << WEBrick::Cookie.new("board", params[:board])
  request.cookies << WEBrick::Cookie.new("player_o", params[:player_o])
  request.cookies << WEBrick::Cookie.new("player_x", params[:player_x])
  request.instance_variable_set("@query", params[:query])
  request
end

def new_post_request(params)
  request = WEBrick::HTTPRequest.new({})
  request.instance_variable_set("@query", params)
  request
end

describe BoardServlet do
  before(:each) do
    TTT.initialize_cache
    @board_servlet = BoardServlet.new({}, TTT::CONFIG.cache)
    @request = {}
    @request[:board] = '3x3'
    @request[:player_o] = 'human'
    @request[:player_x] = 'unbeatable'
    @board_servlet.request = @request
    @response = WEBrick::HTTPResponse.new({:HTTPVersion => "1.0"})
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
    @board_servlet.board = Board.from_moves(array)
    
    @board_servlet.generate_square_html(0).should ==
      "<img border=\"1\" src=\"/images/pieces/x.png\" " +
      "alt=\"square\" width=\"130\" height=\"130\"  />"

    @board_servlet.generate_square_html(1).should ==
      "<img border=\"1\" src=\"/images/pieces/o.png\" " +
      "alt=\"square\" width=\"130\" height=\"130\"  />"

    @board_servlet.generate_square_html(2).should ==
      "<a href=\"/new?s=2\"><img border=\"1\" src=\"/images/pieces/empty_square.png\" " +
      "alt=\"square\" width=\"130\" height=\"130\" onmouseover=\"TTT.mouseOverSquare(this)\" " +
      "onmouseout=\"TTT.mouseOutSquare(this)\"/></a>"
  end

  it "should generate board html" do
    array = [].fill(0, 9) { " " }
    @board_servlet.board = Board.from_moves(array)
    mock_row_html = "mock_row_html"
    @board_servlet.should_receive(:generate_square_html).exactly(9).and_return(mock_row_html)

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

  it "should create game" do
    Game.should_receive(:new).and_return(@board_servlet.game = mock("game"))
    @board_servlet.game.should_receive(:scoreboard=)
    @board_servlet.game.should_receive(:non_blocking_play)
    @board_servlet.start_game
  end

  it "should receive message for do_POST" do
    @board_servlet.should_receive(:create_board)
    @board_servlet.should_receive(:create_players)
    @board_servlet.should_receive(:start_game)
    @board_servlet.should_receive(:add_body_response)
    @board_servlet.should_receive(:create_new_cookies)

    @board_servlet.do_POST(new_post_request({:query => {}}), @response)
  end

  it "should display message" do
    status = mock("status")
    @board_servlet.display_message(status)
    @board_servlet.status.should == status
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

  it "makes a move on an empty board during GET request" do
    params = { :board_state => "-,-,-,-,-,-,-,-,-",
               :board => '3x3',
               :player_o => 'human',
               :player_x => 'human',
               :query => {'s' => '0'} }
    request = new_get_request(params)
    response = WEBrick::HTTPResponse.new({:HTTPVersion => "1.0"})

    @board_servlet = BoardServlet.new({}, TTT::CONFIG.cache)
    @board_servlet.do_GET(request, response)

    cookie(response, "board_state").should == "O,-,-,-,-,-,-,-,-"
    cookie(response, "board").should == "3x3"
    cookie(response, "player_o").should == "human"
    cookie(response, "player_x").should == "human"
  end

  it "makes a full turn on an empty board during GET request" do
    params = { :board_state => "-,-,-,-,-,-,-,-,-",
               :board => '3x3',
               :player_o => 'human',
               :player_x => 'unbeatable',
               :query => {'s' => '0'} }
    request = new_get_request(params)
    response = WEBrick::HTTPResponse.new({:HTTPVersion => "1.0"})

    @board_servlet = BoardServlet.new({}, TTT::CONFIG.cache)
    @board_servlet.do_GET(request, response)

    @board_servlet.game.should_not be_nil
    @board_servlet.player_o.should_not be_nil
    @board_servlet.player_x.should_not be_nil
    cookie(response, "board_state").should == "O,-,-,-,X,-,-,-,-"
    cookie(response, "board").should == "3x3"
    cookie(response, "player_o").should == "human"
    cookie(response, "player_x").should == "unbeatable"
  end

  it "makes a move on an empty board during POST request" do
    params = { "board" => '3x3',
               "player_o" => 'easy',
               "player_x" => 'human' }
    request = new_post_request(params)
    response = WEBrick::HTTPResponse.new({:HTTPVersion => "1.0"})

    @board_servlet = BoardServlet.new({}, TTT::CONFIG.cache)
    @board_servlet.do_POST(request, response)

    cookie(response, "board_state").count('O').should == 1
    cookie(response, "board_state").count('-').should == 8
    cookie(response, "board").should == "3x3"
    cookie(response, "player_o").should == "easy"
    cookie(response, "player_x").should == "human"
  end

  it "does not create players and game when board is game over" do
    params = { :board_state => "O,O,-,X,X,X,-,-,O",
               :board => '3x3',
               :player_o => 'human',
               :player_x => 'unbeatable',
               :query => {'s' => '2'} }
    request = new_get_request(params)
    response = WEBrick::HTTPResponse.new({:HTTPVersion => "1.0"})

    @board_servlet = BoardServlet.new({}, TTT::CONFIG.cache)
    @board_servlet.do_GET(request, response)

    @board_servlet.game.should be_nil
    @board_servlet.player_o.should be_nil
    @board_servlet.player_x.should be_nil
    cookie(response, "board_state").should == "O,O,-,X,X,X,-,-,O"
    cookie(response, "board").should == "3x3"
    cookie(response, "player_o").should == "human"
    cookie(response, "player_x").should == "unbeatable"
  end
end
