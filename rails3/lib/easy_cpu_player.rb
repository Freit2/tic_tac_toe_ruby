require 'player'

class EasyCpuPlayer < Player
  def make_move
    @ui.display_cpu_move_message(@piece)
    squares = @board.empty_squares
    return squares[rand(squares.size)]
  end
end
