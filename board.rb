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
    
    # will go away after minmax algo
    attr_reader :board, :std_out, :winner

    def initialize(std_out)
      @board = [].fill(0, 9) { " " }
      @std_out = std_out
    end

    def occupied?(space)
      if valid_move?(space)
        return (@board.at(space) == " ") ? false : true
      end
      false
    end

    def piece_in(space)
      @board.at(space)
    end

    def valid_move?(space)
      (0..8) === space
    end

    def move(space, piece)
      if valid_move?(space)
        @board.delete_at(space)
        @board.insert(space, piece)
      end
    end

    def display
      @std_out.print "\n\n"
      @std_out.print " #{@board[0]} |"
      @std_out.print " #{@board[1]} |"
      @std_out.print " #{@board[2]}"
      @std_out.print "\n---+---+---\n"
      @std_out.print " #{@board[3]} |"
      @std_out.print " #{@board[4]} |"
      @std_out.print " #{@board[5]}"
      @std_out.print "\n---+---+---\n"
      @std_out.print " #{@board[6]} |"
      @std_out.print " #{@board[7]} |"
      @std_out.print " #{@board[8]}"
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
      false
    end
  end
