class UI
  attr_reader :input, :output
  
  def initialize(input, output)
    @input = input
    @output = output
  end

  def get_input
    return @input.gets
  end

  def display_message(message)
    @output.print message
  end

  def get_player_type(piece)
    display_message("\nChoose player type for '#{piece}' " +
      "('h' for human or 'c' for cpu or 'm' for minmax cpu) ")
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