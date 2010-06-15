class Player
  attr_reader :piece
  attr_accessor :board
  
  def initialize(piece)
    @piece = piece
  end
end
