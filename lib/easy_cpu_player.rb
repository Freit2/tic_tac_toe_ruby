require 'player'

class EasyCpuPlayer < Player
  def make_move
    @ui.display_cpu_move_message(@piece)
    return rand(@board.size)
  end
end