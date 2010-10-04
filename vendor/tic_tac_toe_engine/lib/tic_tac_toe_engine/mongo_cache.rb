begin
  require 'mongo'
rescue LoadError
  require 'rubygems'
  require 'mongo'
end

module TicTacToeEngine
  class MongoCache
    attr_reader :collection

    def self.db_installed?
      begin
        Mongo::Connection.new
      rescue Mongo::ConnectionFailure
        return false
      end
      return true
    end

    def initialize
      @collection = Mongo::Connection.new.db("ttt").collection("boards")
    end

    def score(board, piece)
      bson = @collection.find_one("board" => board, "piece" => piece)
      return bson && bson["score"]
    end

    def memoize(board, piece, score)
      @collection.insert({"board" => board, "piece" => piece, "score" => score})
    end
  end
end
