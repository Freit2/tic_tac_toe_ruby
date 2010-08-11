require 'webrick'
require 'erb'
require 'webrick_ui'

class NilScoreboard
  def add_score(w)
  end
end

class BoardServlet < WEBrick::HTTPServlet::AbstractServlet
  include WEBrickUI

  attr_reader :template, :title, :player_o, :player_x, :thread
  attr_accessor :game, :board, :current_player, :move, :player_allowed, :status

  @@instance = nil
  @@instance_creation_mutex = Mutex.new

  def self.get_instance config, *options
    @@instance_creation_mutex.synchronize do
      @@instance = @@instance || self.new(config, *options)
    end
  end

  def initialize(config, *options)
    super(config)
    @cache = options[0]
    @template = "board_template.rhtml"
    @title = "WEBrick Tic Tac Toe!"
    @player_allowed = false
  end

  def do_GET(request, response)
    if @player_allowed && request.query['s']
      @move = request.query['s'].to_i
      wait_until_move_is_made(@move)
    end

    status, content_type, body = generate_body

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def do_POST(request, response)
    create_board(request.query["board"])
    create_players(request)
    start_game_thread
    
    status, content_type, body = generate_body
    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def convert(rhtml_file)
    return ERB.new IO.read(File.expand_path(File.dirname(__FILE__)) + "/rhtml/#{rhtml_file}")
  end

  def generate_body
    template = convert(@template)
    return 200, "text/html", template.result(binding)
  end

  def create_board(board)
    board_size = board[0,1].to_i ** 2
    @board = Board.new(nil, board_size)
  end

  def generate_status_html
    return "<img src=\"#{@status}\" alt=\"status\" width=\"502\" height=\"75\"/>" if @status
    return ""
  end

  def generate_row_html(s)
    if @board.empty_squares.include?(s)
      a_start = "<a href=\"/new?s=#{s}\">"
      a_end = "</a>"
      image = "empty_square.png"
      on_mouse_over = "onmouseover=\"TTT.mouseOverSquare(this)\""
      on_mouse_out = "onmouseout=\"TTT.mouseOutSquare(this)\""
    else
      a_start = a_end = on_mouse_over = on_mouse_out = ""
      image = "#{@board[s].downcase}.png"
    end
    return ("#{a_start}<img border=\"1\" src=\"/images/pieces/#{image}\" " +
      "alt=\"square\" width=\"130\" height=\"130\" " +
      "#{on_mouse_over} #{on_mouse_out}/>#{a_end}")
  end

  def generate_board_html
    board_html = ""
    @board.ranges.each do |r|
      html = ""
      r.each do |s|
        html += generate_row_html(s)
      end
      board_html += "#{html}<br />"
    end
    return (board_html + "<br />")
  end

  def create_players(request)
    @player_o = Player.create(request.query["player_o"][0,1], TTT::CONFIG.pieces[:o])
    @player_x = Player.create(request.query["player_x"][0,1], TTT::CONFIG.pieces[:x])
    @player_o.ui = self
    @player_x.ui = self
    cache = @cache[TTT::CONFIG.boards[request.query["board"]][:cache]]
    @player_o.cache = cache
    @player_x.cache = cache
  end

  def start_game_thread
    @thread = Thread.new do
      begin
        @game = Game.new(@player_o, @player_x, @board, self)
        @game.scoreboard = NilScoreboard.new
        @game.play
      rescue StandardError => e
        puts e
        puts e.backtrace
      end
    end
    wait_until_game_starts
  end
end
