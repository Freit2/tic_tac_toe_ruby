class GameController < ApplicationController
  attr_accessor :current_player

  def start
    TicTacToeEngine::TTT.initialize_cache if TicTacToeEngine::TTT::CONFIG.cache.length == 0
    @current_player = nil
    if params[:s]
      @request = {:board => cookies[:board],
                  :player_o => cookies[:player_o],
                  :player_x => cookies[:player_x]}
      board_state = cookies[:board_state].gsub(/-/, ' ')
      @board = TicTacToeEngine::Board.parse(board_state)
      if !@board.game_over?
        create_players
        start_game

        if params[:s]
          @move = params[:s].to_i
          if @board.valid_move?(@move)
            @board.move(@move, @game.current_player.piece)
            @game.non_blocking_play
          end
        end
      end
    else
      @request = {:board => params[:board],
                  :player_o => params[:player_o],
                  :player_x => params[:player_x]}
      @status = nil
      create_board
      create_players
      start_game
    end
    cookies[:board_state] = @board.serialize.gsub(/\s/, '-')
    cookies[:board] = @request[:board]
    cookies[:player_o] = @request[:player_o]
    cookies[:player_x] = @request[:player_x]
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

  def display_board(board)
  end

  def display_message(image=nil)
    @status = image
  end

  def human_player_move(piece)
    display_message("/images/messages/move_player_#{piece.downcase}.png")
  end

  def display_cpu_move_message(piece)
  end

  def display_winner(winner)
    display_message("/images/end_message/winner_#{winner.downcase}.png")
  end

  def display_draw_message
    display_message("/images/end_message/draw_game.png")
  end

  def display_scores(s)
  end

  def display_try_again
  end
end
