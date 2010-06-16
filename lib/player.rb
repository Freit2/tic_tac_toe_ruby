class Player
  attr_reader :piece
  attr_accessor :board, :ui
  
  def initialize(piece)
    @piece = piece
  end
end
