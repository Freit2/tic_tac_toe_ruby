class Board
  attr_reader :winning_patterns, :board, :size, :row_size,
              :winner, :win_moves, :last_move

  def initialize(board=nil, size=9)
    @winning_patterns =
      [[(/OOO....../), [0,1,2], :O], [(/...OOO.../), [3,4,5], :O],
       [(/......OOO/), [6,7,8], :O], [(/O..O..O../), [0,3,6], :O],
       [(/.O..O..O./), [1,4,7], :O], [(/..O..O..O/), [2,5,8], :O],
       [(/O...O...O/), [0,4,8], :O], [(/..O.O.O../), [2,4,6], :O],
       [(/XXX....../), [0,1,2], :X], [(/...XXX.../), [3,4,5], :X],
       [(/......XXX/), [6,7,8], :X], [(/X..X..X../), [0,3,6], :X],
       [(/.X..X..X./), [1,4,7], :X], [(/..X..X..X/), [2,5,8], :X],
       [(/X...X...X/), [0,4,8], :X], [(/..X.X.X../), [2,4,6], :X]]
    if board
      @board = board.dup
      find_winner
    else
      @board = [].fill(0, size) { " " }
    end
    @size = @board.size
    @row_size = Math.sqrt(@size).to_i
  end

  def [](index)
    return @board[index]
  end

  def rows
    array = []
    start = 0
    (1..@row_size).each do |r|
      array << @board[start...@row_size*r]
      start = @row_size*r
    end
    return array
  end

  def to_a
    return @board.dup
  end

  def to_s
    return @board.join
  end

  def index(piece)
    return @board.index(piece)
  end

  def occupied?(square)
    return (@board.at(square) == " ") ? false : true
  end

  def piece_in(square)
    return @board.at(square)
  end

  def move(square, piece)
    if !occupied?(square)
      @board.delete_at(square)
      @board.insert(square, piece)
      @last_move = square
      find_winner
    end
  end

  def get_empty_squares
    array = []
    @board.size.times do |s|
      if @board[s].strip == ''
        array << s
      end
    end
    return array
  end

  def valid_move?(square)
    if (0...@size) === square
      return (occupied?(square)) ? false : true
    end
    return false
  end

  def game_over?
    if !someone_win? && @board.index(" ")
      return false
    end
    return true
  end

  def find_winner
    array = @winning_patterns.find { |p| p.first =~ @board.join }
    if array
      @winner = (array.last === :X) ? 'X' : 'O'
      @win_moves = array[1]
    end
  end

  def someone_win?
    find_winner
    if @winner
      return true
    end
    return false
  end
end
