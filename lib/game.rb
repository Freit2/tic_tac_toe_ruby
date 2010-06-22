require 'std_ui'

class Game
  attr_reader :board, :ui, :player1, :player2

  def initialize(player1, player2, board, ui)
    @board = board
    @ui = ui
    @player1 = player1
    @player1.board = @board
    @player2 = player2
    @player2.board = @board
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
      player_move = get_move_from(player)
      @board.move(player_move, player.piece)
      @ui.display_board(@board)
    end
  end

  def play_turn
    make_move(@player1)
    make_move(@player2)
  end

  def play
    @ui.display_board(@board)
    5.times do
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
