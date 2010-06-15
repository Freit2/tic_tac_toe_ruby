require 'board'

class Game
  attr_reader :board, :player1, :player2

  def initialize(player1, player2, board)
    @board = board
    @player1 = player1
    @player1.board = @board
    @player2 = player2
    @player2.board = @board
  end

  def valid_move?(space)
    if (0..8) === space
      return (@board.occupied?(space)) ? false : true
    end
    return false
  end

  def get_move_from(player)
    loop do
      move = player.make_move
      if valid_move?(move)
        return move
      end
    end
  end

  def make_move(player)
    if !@board.game_over?
      player_move = get_move_from(player)
      @board.move(player_move, player.piece)
      @board.display
    end
  end

  def play_turn
    make_move(@player1)
    make_move(@player2)
  end

  def play
    @board.display
    5.times do
      play_turn
    end
    return get_end_message
  end

  def get_end_message
    if @board.winner
      "The winner is #{@board.winner}."
    else
      "The game is a draw."
    end
  end
end
