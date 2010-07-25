require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'player'
require 'board'
require 'rubygems'
require 'mongo'

class NegamaxPlayer < Player

  attr_reader :coll
  attr_accessor :scores, :documents

  def initialize(piece)
    super(piece)
    @max = piece
    @coll = Mongo::Connection.new.db("ttt").collection("boards")
    @documents = []
  end

  def make_move
    @ui.display_cpu_move_message(@piece)
    @documents.clear
    @scores = [].fill(0, @board.size) { -999 }
    memoize_negamax(@board, @piece, 1)
    puts @scores.inspect
    @coll.insert(@documents)
    return best_random_move
  end

  def get_opponent(piece)
    return piece === 'O' ? 'X' : 'O'
  end

  def evaluate_score(board, piece, depth)
    opponent = get_opponent(piece)
    case board.winner
    when piece
      return (depth == 2) ? 2 : 1
    when opponent
      return (depth == 2) ? -2 : -1
    else
      return 0
    end
  end

  def get_score_from_hash(board, piece)
    hash = @documents.select { |h| h["board"] == board &&
      h["piece"] == piece }[0]
    if !hash
      bson = @coll.find_one("board" => board, "piece" => piece)
      score = bson && bson["score"]
    else
      score = hash["score"]
    end
    return score
  end

  def store_hash(board, piece, score)
    @documents << {"board" => board,
      "piece" => piece, "score" => score}
    if @documents.size > 75
      @coll.insert(@documents)
      @documents.clear
    end
  end

  def memoize_negamax(board, piece, depth)
    if board.game_over?
      return evaluate_score(board, piece, depth)
    else
      best_score = -999
      opponent = get_opponent(piece)
      empty_squares = board.get_empty_squares
      empty_squares.each do |s|
        board.move(s, piece)
        score = get_score_from_hash(board.to_s, piece)
        if !score
          score = -memoize_negamax(board, opponent, depth + 1)
          store_hash(board.to_s, piece, score)
        elsif (piece == @max && score == 1 && depth == 1)
          score = [evaluate_score(board, piece, 2), score].max
        end
        board.clear(s)
        @scores[s] = score if depth == 1
        if score > best_score
          best_score = score
        end
      end
      return best_score
    end
  end

  def indexes_of_max(array)
    max = array.max
    returning [] do |indexes|
      array.each_with_index do |e, i|
        indexes << i if e == max
      end
    end
  end

  def best_random_move
    indexes = indexes_of_max(@scores)
    return indexes[rand(indexes.size)]
  end
end
