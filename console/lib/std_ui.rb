class StdUI
  attr_reader :input, :output
  attr_accessor :current_player
  
  def initialize(input=STDIN, output=STDOUT)
    @input = input
    @output = output
  end

  def user_input
    return @input.gets
  end

  def display_message(message)
    @output.print message
  end

  def board_type(active_boards)
    message = "\nChoose board type (enter "
    count = 0
    active_boards.each do |board|
      message += " or " if count == 1
      message += "'#{board[0,1]}' for #{board}"
      count += 1
    end
    message += ") "
    loop do
      display_message(message)
      input = user_input.to_s.chomp
      active_boards.each do |board|
        return input if input == board[0,1]
      end
    end
  end

  def player_type(piece)
    display_message("\nChoose player type for '#{piece}' " +
      "(enter 'h' for human or 'e' for easy cpu, " +
      "'m' for  medium cpu or 'u' for unbeatable cpu) ")
    return user_input.to_s.chomp
  end

  def human_player_move(piece)
    display_message("\nEnter your move, player '#{piece}': ")
    return user_input.to_i
  end

  def display_cpu_move_message(piece)
    display_message("Player '#{piece}' is making a move\n")
  end

  def board_layout(board)
    board_line = "\n#{([].fill(0, board.row_size) { "---" }).join('+')}\n"
    array = []
    board.rows.each do |r|
      array << r.join(' | ')
    end
    return "\n\n #{array.join(" #{board_line} ")} \n\n"
  end

  def display_board(board)
      display_message(board_layout(board))
  end

  def scoreboard(scores)
    o = scores[:o]
    x = scores[:x]
    line =   "\n-----------------------------------\n"
    columns =  "            wins   losses   draws  \n"
    player_o = "player O     #{o[:wins]}       #{o[:losses]}       #{o[:draws]}     \n"
    player_x = "player X     #{x[:wins]}       #{x[:losses]}       #{x[:draws]}     \n"
    return "\n" + line + columns + player_o + player_x + line
  end

  def display_scores(score_board)
    display_message(scoreboard(score_board.scores))
  end

  def display_try_again
    display_message("\n\nDo you want to play again? ('y' or 'n') ")
  end

  def play_again
    return user_input.to_s.chomp
  end

  def display_winner(winner)
    display_message("The winner is #{winner}.")
  end

  def display_draw_message
    display_message("The game is a draw.")
  end

  def display_exit_message
    display_message("\nThanks for playing!\n\n")
  end
end
