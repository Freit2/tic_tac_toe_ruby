require 'webrick'
require 'erb'
require 'webrick_ui'

class BoardServlet < WEBrick::HTTPServlet::AbstractServlet
  include WEBrickUI

  attr_reader :board, :player_o, :player_x

  def self.get_instance config, *options
    load __FILE__
    new config, *options
  end

  def initialize(config, *options)
    super(config)
    @options = *options
  end

  def do_GET(request, response)
    puts "do_GET"
  end

  def do_POST(request, response)
    puts "do_POST"

    status, content_type, body = ttt(request)

    response.status = status
    response['Content-Type'] = content_type
    response.body = body
  end

  def create_board(board)
    board_size = board[0,1].to_i ** 2
    @board = Board.new(nil, board_size)
  end

  def create_players(request)
    @player_o = Player.create(request["player_o"][0,1], 'O')
    @player_x = Player.create(request["player_x"][0,1], 'X')
    @player_o.ui = self
    @player_x.ui = self
    cache = @options[TTT::CONFIG.boards[request["board"]][:cache]]
    @player_o.cache = cache
    @player_x.cache = cache
  end

  def display_board

  end

  def start_game_thread

  end

  def erbize(erb_file)
    return ERB.new IO.read(erb_file)
  end

  def ttt(request)
    title = "WEBrick Tic Tac Toe!"
    #request.query.collect { |key, value| puts "#{key} : #{value}" }
    template = erbize("board_template.erb")
    return 200, "text/html", template.result(binding)
  end
end
