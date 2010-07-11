class StdUI
  attr_reader :input, :output
  attr_accessor :current_player
  
  def initialize(input=STDIN, output=STDOUT)
    @input = input
    @output = output
  end

  def get_input
    return @input.gets
  end

  def display_message(message)
    @output.print message
  end

  def get_board_type
    display_message("\nChoose board type (enter '3' for 3x3 or '4' for 4x4)")
    return get_input.to_s.chomp
  end

  def get_player_type(piece)
    display_message("\nChoose player type for '#{piece}' " +
      "(enter 'h' for human or 'e' for easy cpu, " +
      "'m' for  medium cpu or 'u' for unbeatable cpu) ")
    return get_input.to_s.chomp
  end

  def get_play_again
    display_message("\n\nDo you want to play again? ('y' or 'n') ")
    return get_input.to_s.chomp
  end

  def get_human_player_move(piece)
    display_message("\nEnter your move, player '#{piece}' [0-8]: ")
    return get_input.to_i
  end

  def display_cpu_move_message(piece)
    display_message("Player '#{piece}' is making a move\n")
  end

  def get_board(board)
    #board_line = "\n#{([].fill(0, board.row_size) { "---" }).join('+')}\n"
    #board_layout = 
    #return
  end

  def display_board(board)
      board_line = "\n---+---+---\n"
      message = "\n\n #{board[0..2].join(' | ')} " +
        "#{board_line} #{board[3..5].join(' | ')} " +
        "#{board_line} #{board[6..8].join(' | ')} \n\n"
      
      display_message(message)
  end

  def display_exit_message
    display_message("\nThanks for playing!\n\n")
  end

  def display_winner(winner)
    display_message("The winner is #{winner}.")
  end

  def display_draw_message
    display_message("The game is a draw.")
  end
end