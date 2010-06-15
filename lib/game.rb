require 'board'

class Game
  attr_reader :board, :player1, :player2

  def initialize(player1, player2, board)
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def get_move_from(player)
    loop do
      move = player.make_move(@board)
      if (0..8) === move
        return move
      end
    end
  end

  def play_turn
    unless @board.game_over?
      player1_move = get_move_from(@player1)
      @board.move(player1_move, @player1.piece)
      @board.display
    end

    unless @board.game_over?
      player2_move = get_move_from(@player2)
      @board.move(player2_move, @player2.piece)
      @board.display
    end
  end

  def play
    5.times do
      play_turn
    end
    get_end_message
  end

  def get_end_message
    if @board.winner
      "The winner is #{@board.winner}."
    else
      "The game is a draw."
    end
  end
end
