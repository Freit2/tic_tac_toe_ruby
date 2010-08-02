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

  def get_board_type(active_boards)
    message = "\nChoose board type (enter "
    count = 0
    active_boards.each do |board|
      message += " or " if count == 1
      message += "'#{board[0,1]}' for #{board}"
    end
    message += ") "
    loop do
      display_message(message)
      input = get_input.to_s.chomp
      active_boards.each do |board|
        return input if input == board[0,1]
      end
    end
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
    display_message("\nEnter your move, player '#{piece}': ")
    return get_input.to_i
  end

  def display_cpu_move_message(piece)
    display_message("Player '#{piece}' is making a move\n")
  end

  def get_board(board)
    board_line = "\n#{([].fill(0, board.row_size) { "---" }).join('+')}\n"
    array = []
    board.rows.each do |r|
      array << r.join(' | ')
    end
    return "\n\n #{array.join(" #{board_line} ")} \n\n"
  end

  def display_board(board)
      display_message(get_board(board))
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