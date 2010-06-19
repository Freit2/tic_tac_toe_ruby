class Board
  attr_reader :board, :size
  attr_accessor :winner

  def initialize(board=nil, size=9)
    @won_patterns =
      [[(/OOO....../), :O], [(/...OOO.../), :O],
       [(/......OOO/), :O], [(/O..O..O../), :O],
       [(/.O..O..O./), :O], [(/..O..O..O/), :O],
       [(/O...O...O/), :O], [(/..O.O.O../), :O],
       [(/XXX....../), :X], [(/...XXX.../), :X],
       [(/......XXX/), :X], [(/X..X..X../), :X],
       [(/.X..X..X./), :X], [(/..X..X..X/), :X],
       [(/X...X...X/), :X], [(/..X.X.X../), :X]]
    if board
      @size = board.size
      @board = board.dup
      find_winner
    else
      @size = size
      @board = [].fill(0, @size) { " " }
    end
  end

  def [](index)
    return @board[index]
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
      find_winner
    end
  end

  def get_empty_squares
    array = []
    @board.size.times do |s|
      if @board[s] == ' '
        array << s
      end
    end
    return array
  end

  def valid_move?(square)
    if (0..@size-1) === square
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
    array = @won_patterns.find { |p| p.first =~ @board.join }
    if array
      @winner = (array.last === :X) ? 'X' : 'O'
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
