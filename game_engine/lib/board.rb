class Board
  attr_reader :winning_patterns, :board, :size, :row_size,
              :win_moves, :last_move
  attr_accessor :winner

  def initialize(board=nil, size=9)
    if board
      @board = board.dup
    else
      @board = [].fill(0, size) { " " }
    end
    @size = @board.size
    @row_size = Math.sqrt(@size).to_i
    set_patterns
  end

  def [](index)
    return @board[index]
  end

  def ranges
    array = []
    start = 0
    (1..@row_size).each do |r|
      array << (start...@row_size*r)
      start = @row_size*r
    end
    return array
  end

  def rows
    array = []
    ranges.each do |r|
      array << @board[r]
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
      @board[square] = piece
      @last_move = square
      find_winner
    end
  end

  def clear(square)
    @board[square] = " "
    @winner = nil
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

  private
  def set_patterns
    case @size
    when 9
      @winning_patterns =
        [[(/OOO....../), [0,1,2], :O], [(/...OOO.../), [3,4,5], :O],
         [(/......OOO/), [6,7,8], :O], [(/O..O..O../), [0,3,6], :O],
         [(/.O..O..O./), [1,4,7], :O], [(/..O..O..O/), [2,5,8], :O],
         [(/O...O...O/), [0,4,8], :O], [(/..O.O.O../), [2,4,6], :O],
         [(/XXX....../), [0,1,2], :X], [(/...XXX.../), [3,4,5], :X],
         [(/......XXX/), [6,7,8], :X], [(/X..X..X../), [0,3,6], :X],
         [(/.X..X..X./), [1,4,7], :X], [(/..X..X..X/), [2,5,8], :X],
         [(/X...X...X/), [0,4,8], :X], [(/..X.X.X../), [2,4,6], :X]]
    when 16
      @winning_patterns =
        [[(/OOOO............/), [0,1,2,3],     :O], [(/....OOOO......../), [4,5,6,7],     :O],
         [(/........OOOO..../), [8,9,10,11],   :O], [(/............OOOO/), [12,13,14,15], :O],
         [(/O...O...O...O.../), [0,4,8,12],    :O], [(/.O...O...O...O../), [1,5,9,13],    :O],
         [(/..O...O...O...O./), [2,6,10,14],   :O], [(/...O...O...O...O/), [3,7,11,15],   :O],
         [(/O....O....O....O/), [0,5,10,15],   :O], [(/...O..O..O..O.../), [3,6,9,12],    :O],
         [(/XXXX............/), [0,1,2,3],     :X], [(/....XXXX......../), [4,5,6,7],     :X],
         [(/........XXXX..../), [8,9,10,11],   :X], [(/............XXXX/), [12,13,14,15], :X],
         [(/X...X...X...X.../), [0,4,8,12],    :X], [(/.X...X...X...X../), [1,5,9,13],    :X],
         [(/..X...X...X...X./), [2,6,10,14],   :X], [(/...X...X...X...X/), [3,7,11,15],   :X],
         [(/X....X....X....X/), [0,5,10,15],   :X], [(/...X..X..X..X.../), [3,6,9,12],    :X]]
    end
  end
end
