require 'player'

class HumanPlayer < Player
  def initialize(piece)
    super(piece)
  end

  def make_move()
    @ui.display_message("\nEnter your move, player '#{@piece}' [0-8]: ")
    return @ui.get_input.to_i
  end
end
