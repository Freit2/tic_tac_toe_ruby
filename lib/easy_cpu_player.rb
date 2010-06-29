require 'player'

class EasyCpuPlayer < Player
  def make_move
    return rand(@board.size)
  end
end