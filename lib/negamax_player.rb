require File.expand_path(File.dirname(__FILE__)) + "/init" 
require 'player'
require 'board'

class NegamaxPlayer < Player

  attr_accessor :best_move

  def initialize(piece)
    super(piece)
  end

  def make_move
    @ui.display_cpu_move_message(@piece)
    if @board.get_empty_squares.size == @board.size
      return rand(@board.size)
    end
    get_alpha_beta_move(@board, @piece, 1, -999, 999)
    moves = get_rotated_moves
    return moves[rand(moves.size)]
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

  def get_alpha_beta_move(board, piece, depth, alpha, beta)
    if board.game_over?
      return evaluate_score(board, piece, depth)
    else
      opponent = get_opponent(piece)
      empty_squares = board.get_empty_squares
      empty_squares.each do |s|
        temp_board = Board.new(board.to_a)
        temp_board.move(s, piece)
        score = -get_alpha_beta_move(temp_board, opponent, depth + 1, -beta, -alpha)
        if score > alpha
          alpha = score
          @best_move = s if depth == 1
        end
        break if alpha >= beta
      end
      return alpha
    end
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
