class TicTacToe
  include UI

  attr_reader :player_x, :player_o
  attr_accessor :game, :request, :board, :current_player, :status

  def self.resume params, cookies
    board_state = cookies[:board_state].gsub(/-/, ' ')
    board = TicTacToeEngine::Board.parse(board_state)

    ttt = TicTacToe.new
    ttt.request = {:board => cookies[:board],
                :player_o => cookies[:player_o],
                :player_x => cookies[:player_x]}
    ttt.board = board
    if !ttt.board.game_over?
      ttt.create_players
      ttt.start_game

      move = params[:s].to_i
      if ttt.board.valid_move?(move)
        ttt.board.move(move, ttt.game.current_player.piece)
        ttt.game.non_blocking_play
      end
    end

    ttt
  end

  def self.start params
    ttt = TicTacToe.new
    ttt.request = {:board => params[:board],
                :player_o => params[:player_o],
                :player_x => params[:player_x]}
    ttt.create_board
    ttt.create_players
    ttt.start_game

    ttt
  end

  def initialize
    TicTacToeEngine::TTT.initialize_cache if TicTacToeEngine::TTT::CONFIG.cache.length == 0
  end

  def create_board
    board_size = @request[:board][0,1].to_i ** 2
    @board = TicTacToeEngine::Board.new(board_size)
  end

  def create_players
    @player_o = TicTacToeEngine::Player.create(@request[:player_o][0,1], TicTacToeEngine::TTT::CONFIG[:pieces][:o])
    @player_x = TicTacToeEngine::Player.create(@request[:player_x][0,1], TicTacToeEngine::TTT::CONFIG[:pieces][:x])
    @player_o.ui = self
    @player_x.ui = self
    cache = TicTacToeEngine::TTT::CONFIG.cache[TicTacToeEngine::TTT::CONFIG[:boards][@request[:board].to_sym][:cache]]
    @player_o.cache = cache
    @player_x.cache = cache
  end

  def start_game
    @game = TicTacToeEngine::Game.new(@player_o, @player_x, @board, self)
# TODO: Replace with real Scoreboard class
    @game.scoreboard = TicTacToeEngine::NilScoreboard.new
    @game.non_blocking_play
  end
end
