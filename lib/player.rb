class Player
  attr_reader :piece
  attr_accessor :board, :ui
  
  def initialize(piece)
    @piece = piece
  end

  def self.create(player, piece)
    case player.upcase
    when 'H'
      require 'human_player'
      return HumanPlayer.new(piece)
    when 'E'
      require 'easy_cpu_player'
      return EasyCpuPlayer.new(piece)
    when 'M'
      require 'cpu_player'
      return CpuPlayer.new(piece)
    when 'U'
      require 'min_max_player'
      return MinMaxPlayer.new(piece)
    end
  end
end
