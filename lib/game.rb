require 'std_ui'

class Game
  attr_reader :board, :ui, :player_o, :player_x

  def initialize(player_o, player_x, board, ui)
    @board = board
    @ui = ui
    @player_o = player_o
    @player_x = player_x
    @player_o.board = @board
    @player_x.board = @board
  end

  def get_move_from(player)
    loop do
      move = player.make_move
      if @board.valid_move?(move)
        return move
      end
    end
  end

  def make_move(player)
    if !@board.game_over?
      @ui.current_player = player
      player_move = get_move_from(player)
      @board.move(player_move, player.piece)
      @ui.display_board(@board)
    end
  end

  def play_turn
    make_move(@player_o)
    make_move(@player_x)
  end

  def play
    @ui.display_board(@board)
    (@board.size/2.0).round.times do
      play_turn
    end
    display_end_message
  end

  def display_end_message
    if @board.winner
      @ui.display_winner(@board.winner)
    else
      @ui.display_draw_message
    end
  end
end
