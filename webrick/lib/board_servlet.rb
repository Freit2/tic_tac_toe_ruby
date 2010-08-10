require 'webrick'
require 'erb'
require 'webrick_ui'

class BoardServlet < WEBrick::HTTPServlet::AbstractServlet
  include WEBrickUI

  attr_reader :board, :player_o, :player_x

  @@instance = nil
  @@instance_creation_mutex = Mutex.new

  def self.get_instance config, *options
    @@instance_creation_mutex.synchronize do
      @@instance = @@instance || self.new(config, *options)
    end
  end

  def initialize(config, *options)
puts "BoardServlet initialize"
    super(config)
    @options = *options
    @template = "board_template.rhtml"
  end

  def do_GET(request, response)
puts "BoardServlet do_GET"
    if request.query['pos']
puts request.query['pos']
      response.set_redirect(WEBrick::HTTPStatus::Found, "/new")
    end

puts "player o is #{@player_o.class}"
puts "player x is #{@player_x.class}"
puts "board size is #{@board.size}"

    status, content_type, body = generate_body(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def do_POST(request, response)
puts "BoardServlet do_POST"

    create_board(request.query["board"])
    create_players(request)
    status, content_type, body = generate_body(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def convert(rhtml_file)
    return ERB.new IO.read(File.expand_path(File.dirname(__FILE__)) + "/rhtml/#{rhtml_file}")
  end

  def generate_body(request)
    title = "WEBrick Tic Tac Toe!"
    #request.query.collect { |key, value| puts "#{key} : #{value}" }
    template = convert(@template)
    return 200, "text/html", template.result(binding)
  end

  def create_board(board)
    board_size = board[0,1].to_i ** 2
    @board = Board.new(nil, board_size)
  end

  def generate_board
    board_html = ""
    @board.ranges.each do |r|
      html = ""
      r.each do |s|
        html += ("<a href=\"/new?pos=#{s}\"><img border=\"1\" src=\"/images/empty_square.png\" " +
          "alt=\"blank square\" width=\"130\" height=\"130\" " +
          "onmouseover=\"TTT.mouseOverSquare(this)\" onmouseout=\"TTT.mouseOutSquare(this)\"/></a>")
      end
      board_html += "#{html}<br />"
    end
    return (board_html + "<br />")
  end

  def create_players(request)
    @player_o = Player.create(request.query["player_o"][0,1], 'O')
    @player_x = Player.create(request.query["player_x"][0,1], 'X')
    @player_o.ui = self
    @player_x.ui = self
    cache = @options[TTT::CONFIG.boards[request.query["board"]][:cache]]
    @player_o.cache = cache
    @player_x.cache = cache
  end

  def start_game_thread

  end
end
