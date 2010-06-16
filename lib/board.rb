  class Board
    attr_reader :board, :size, :winner

    def initialize(size=9)
      @size = size
      @board = [].fill(0, @size) { " " }
      @won_patterns =
        [[(/OOO....../),:O], [(/...OOO.../),:O],
         [(/......OOO/),:O], [(/O..O..O../),:O],
         [(/.O..O..O./),:O], [(/..O..O..O/),:O],
         [(/O...O...O/),:O], [(/..O.O.O../),:O],
         [(/XXX....../),:X], [(/...XXX.../),:X],
         [(/......XXX/),:X], [(/X..X..X../),:X],
         [(/.X..X..X./),:X], [(/..X..X..X/),:X],
         [(/X...X...X/),:X], [(/..X.X.X../),:X]]
    end

    def [](index)
      return @board[index]
    end

    def to_s
      return @board.join
    end
    
    def index(piece)
      return @board.index(piece)
    end

    def occupied?(space)
      return (@board.at(space) == " ") ? false : true
    end

    def piece_in(space)
      return @board.at(space)
    end

    def move(space, piece)
      if !occupied?(space)
        @board.delete_at(space)
        @board.insert(space, piece)
      end
    end

    def game_over?
      if !someone_win?
        if @board.index(" ")
          return false
        end
      end
      return true
    end

    def someone_win?
      array = @won_patterns.find { |p| p.first =~ @board.join }
      if array
        @winner = (array.last === :X) ? 'X' : 'O'
        return true
      end
      return false
    end
  end
