require 'player'

class EasyCpuPlayer < Player
  def make_move
    @ui.display_cpu_move_message(@piece)
    spaces = @board.get_empty_squares
    return spaces[rand(spaces.size)]
  end
end