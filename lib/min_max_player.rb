require 'player'
require 'board'

class MinMaxPlayer < Player
  attr_reader :max, :min
  attr_accessor :eval_piece

  def initialize(piece)
    super(piece)
    @max = @piece
    @min = (@piece == 'O') ? 'X' : 'O'
  end

  def evaluate_score(board)
    other_piece = (@eval_piece == 'O') ? 'X' : 'O'
    case board.winner
    when @eval_piece
      return 1
    when other_piece
      return -1
    else
      return 0
    end
  end

  def get_score(board, piece, depth)
    if board.game_over?
      return depth * evaluate_score(board)
    else
      best_score = -999
      empty_squares = board.get_empty_squares
      empty_squares.each do |s|
        temp_board = Board.new(board.to_a)
        temp_board.move(s, piece)
        score = get_score(temp_board, (piece == @max) ? @min : @max, depth/=2)
        if score > best_score
          best_score = score
        end
      end
      return best_score
    end
  end

  def get_best_move(board)
    if board.get_empty_squares.size == board.size
      return 4
    end
    scores = [].fill(0, board.size) { -1 }
    empty_squares = board.get_empty_squares
    empty_squares.each do |s|
      temp_board = Board.new(board.to_a)
      temp_board.move(s, @max)
      @eval_piece = @max
      score_of_max = get_score(temp_board, @min, 100)
      temp_board = Board.new(board.to_a)
      @eval_piece = @min
      temp_board.move(s, @min)
      score_of_min = get_score(temp_board, @max, 100)
      puts "max : #{score_of_max}, min : #{score_of_min}"
      scores[s] = (score_of_max > score_of_min) ? score_of_max : score_of_min
    end
    puts scores.join(',')
    best_score = scores.max
    if scores.count(best_score)
      # randomize
      return scores.index(best_score)
    else
      return scores.index(best_score)
    end
  end

  def make_move
    @ui.display_message("Player '#{@piece}' makes a move\n")
    return get_best_move(@board)
  end
end

if $0 == __FILE__
  require 'ui'
  require 'board'
  min_max = MinMaxPlayer.new('O')
  min_max.ui = UI.new(STDIN, STDOUT)
  min_max.board = Board.new
  min_max.make_move
end