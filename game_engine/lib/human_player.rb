require 'player'

class HumanPlayer < Player
  def initialize(piece)
    super(piece)
  end

  def make_move
    return @ui.human_player_move(@piece)
  end
end
