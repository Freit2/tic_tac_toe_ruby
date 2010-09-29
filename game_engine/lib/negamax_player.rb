require 'player'

class NegamaxPlayer < Player

  attr_accessor :scores

  def initialize(piece)
    super(piece)
    @max = piece
  end

  def make_move
    @ui.display_cpu_move_message(@piece)
    @scores = [].fill(0, @board.size) { -999 }
    negamax(Board.from_moves(@board.to_a), @piece, 1)
    #puts @scores.inspect
    return best_random_move
  end

  def opponent(piece)
    return piece === 'O' ? 'X' : 'O'
  end

  def evaluate_score(board, piece, depth)
    opponent = opponent(piece)
    case board.winner
    when piece
      return (depth == 2) ? 2 : 1
    when opponent
      return (depth == 2) ? -2 : -1
    else
      return 0
    end
  end

  def negamax(board, piece, depth)
    if board.game_over?
      return evaluate_score(board, piece, depth)
    else
      best_score = -999
      opponent = opponent(piece)
      empty_squares = board.empty_squares
      empty_squares.each do |s|
        board.move(s, piece)
        score = @cache.score(board.to_s, piece)
        if !score
          score = -negamax(board, opponent, depth + 1)
          @cache.memoize(board.to_s, piece, score)
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
    indexes = []
    array.each_with_index do |e, i|
      indexes << i if e == max
    end
    indexes
  end

  def best_random_move
    indexes = indexes_of_max(@scores)
    return indexes[rand(indexes.size)]
  end
end
