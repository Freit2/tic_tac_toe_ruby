require 'player'
require 'board'

class MinMaxPlayer < Player

  def initialize(piece)
    super(piece)
  end

  def make_move
    @ui.display_cpu_move_message(@piece)
    if @board.get_empty_squares.size == @board.size
      return rand(@board.size)
    end
    get_best_move(@board, @piece, 1)
    return @best_move
  end

  def get_opponent(piece)
    return piece === 'O' ? 'X' : 'O'
  end

  def evaluate_score(board, piece)
    opponent = get_opponent(piece)
    case board.winner
    when piece
      return 1
    when opponent
      return -1
    else
      return 0
    end
  end

  def get_best_move(board, piece, depth)
    if board.game_over?
      return evaluate_score(board, piece)
    else
      best_score = -999
      opponent = get_opponent(piece)
      empty_squares = board.get_empty_squares
      empty_squares.each do |s|
        temp_board = Board.new(board.to_a)
        temp_board.move(s, piece)
        score = -get_best_move(temp_board, opponent, depth + 1)
        if score > best_score
          best_score = score
          @best_move = s if depth == 1
        end
      end
      return best_score
    end
  end
end