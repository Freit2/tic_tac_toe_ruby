require 'player'

class HumanPlayer < Player
  def initialize(piece)
    super(piece)
  end

  def make_move
    return @ui.get_human_player_move(@piece)
  end
end
