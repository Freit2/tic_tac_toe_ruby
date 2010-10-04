module TicTacToeEngine
  class Player
    attr_reader :piece
    attr_accessor :board, :ui, :cache

    def self.create(player, piece)
      case player.upcase
      when 'H'
        return HumanPlayer.new(piece)
      when 'E'
        return EasyCpuPlayer.new(piece)
      when 'M'
        return CpuPlayer.new(piece)
      when 'U'
        return NegamaxPlayer.new(piece)
      end
    end

    def initialize(piece)
      @piece = piece
    end
  end
end
