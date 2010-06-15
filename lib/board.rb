  class Board
    module Pattern
      Won = 
        [[(/OOO....../),:O], [(/...OOO.../),:O],
         [(/......OOO/),:O], [(/O..O..O../),:O],
         [(/.O..O..O./),:O], [(/..O..O..O/),:O],
         [(/O...O...O/),:O], [(/..O.O.O../),:O],
         [(/XXX....../),:X], [(/...XXX.../),:X],
         [(/......XXX/),:X], [(/X..X..X../),:X],
         [(/.X..X..X./),:X], [(/..X..X..X/),:X],
         [(/X...X...X/),:X], [(/..X.X.X../),:X]]
    end

    attr_reader :board, :std_out, :winner

    def initialize(std_out)
      @board = [].fill(0, 9) { " " }
      @std_out = std_out
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

    def display
      @std_out.print "\n\n"
      @std_out.print " #{@board[0..2].join(' | ')} "
      @std_out.print "\n---+---+---\n"
      @std_out.print " #{@board[3..5].join(' | ')} "
      @std_out.print "\n---+---+---\n"
      @std_out.print " #{@board[6..8].join(' | ')} "
      @std_out.print "\n\n"
    end

    def game_over?
      unless someone_win?
        if @board.index(" ")
          return false
        end
      end
      true
    end

    def someone_win?
      array = Pattern::Won.find { |p| p.first =~ @board.join }
      if array
        @winner = (array.last === :X) ? 'X' : 'O'
        return true
      end
      return false
    end
  end
