module TicTacToeEngine
  class HashCache
    attr_accessor :collection

    def initialize
      @collection = []
    end

    def score(board, piece)
      hash = @collection.select { |h| h["board"] == board && h["piece"] == piece }[0]
      return hash && hash["score"]
    end

    def memoize(board, piece, score)
      @collection << {"board" => board, "piece" => piece, "score" => score}
    end
  end
end
