require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'player'
require 'board'
require 'rubygems'
require 'mongo'

class NegamaxPlayer < Player

  attr_accessor :scores

  def initialize(piece)
    super(piece)
    @max = piece
    @coll = Mongo::Connection.new.db("ttt").collection("boards")
  end

  def make_move
    @ui.display_cpu_move_message(@piece)
    @scores = [].fill(0, @board.size) { -999 }
    memoize_negamax(@board, @piece, 1)
    #puts @scores.inspect
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

  def memoize_negamax(board, piece, depth)
    if board.game_over?
      return evaluate_score(board, piece, depth)
    else
      best_score = -999
      opponent = get_opponent(piece)
      empty_squares = board.get_empty_squares
      empty_squares.each do |s|
        board.move(s, piece)
        bson = @coll.find_one("board" => board.to_s, "piece" => piece)
        score = bson && bson["score"]
        if !score
          score = -memoize_negamax(board, opponent,
                  depth + 1)
          @coll.insert({"board" => board.to_s, "piece" => piece, "score" => score})
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

  def get_rotated_moves
    rotated_moves = []
    template = (0...@board.size).to_a
    new_template = []
    array = @board.to_a.dup
    new_array = []
    3.times do
      @board.ranges.each do |r|
        new_template << template[r].reverse
        new_array << array[r].reverse
      end
      new_template = new_template.transpose.flatten
      new_array = new_array.transpose.flatten
      if @board.to_a == new_array
        rotated_moves << new_template[@best_move]
      end
      template = new_template.dup
      array = new_array.dup
      new_template.clear
      new_array.clear
    end
    return rotated_moves << @best_move
  end
end
