module DefaultScene

  attr_reader :player_o, :player_x
  attr_accessor :board, :current_player, :move, :player_allowed
  prop_reader :status, :player_o_type, :player_x_type, :start_button, :exit_button,
              :square_0, :square_1, :square_2, :square_3, :square_4, :square_5,
              :square_6, :square_7, :square_8

  def scene_opened(e)
    @player_allowed = false
  end

  def clear_squares
    (0...@board.size).each do |s|
      instance_eval("square_#{s}").text = ""
    end
  end

  def enable_squares
    (0...@board.size).each do |s|
      instance_eval("square_#{s}.enable")
    end
  end

  def disable_squares
    (0...@board.size).each do |s|
      instance_eval("square_#{s}.disable")
    end
  end

  def get_player(player, piece)
    case player
      when 'human'
        return HumanPlayer.new(piece)
      when 'easy cpu'
        return EasyCpuPlayer.new(piece)
      when 'medium cpu'
        return CpuPlayer.new(piece)
      when 'unbeatable cpu'
        return MinMaxPlayer.new(piece)
    end
  end

  def create_players
    @player_o = get_player(player_o_type.text, 'O')
    @player_x = get_player(player_x_type.text, 'X')
    @player_o.ui = self
    @player_x.ui = self
  end

  def play_new_game
    @board = Board.new
    clear_squares
    start_button.disable
    create_players
    enable_squares
    @game_thread = Thread.new do
      begin
        @game = Game.new(@player_o, @player_x, @board, self)
        @game.play
      rescue StandardError => e
        puts e
        puts e.backtrace
      end
    end
  end

  def wait_for_move
    @player_allowed = true
    @move = nil
    while (@move == nil)
      sleep(0.25)
    end
    @player_allowed = false
    return @move
  end

  def display_message(message)
    status.text = message
  end

  def piece_color
    return (current_player.piece == 'X') ? :light_blue : :crimson
  end

  def display_board(board)
    instance_eval("square_#{board.last_move}").animate_move if board.last_move
  end

  def get_human_player_move(piece)
    display_message("Your move player '#{piece}'")
    return wait_for_move
  end

  def display_cpu_move_message(piece)
    display_message("Player '#{piece}' is making a move")
    sleep(0.5)
  end

  def display_winner(winner)
    display_message("The winner is #{winner}.")
    display_try_again
  end

  def display_draw_message
    display_message("The game is a draw.")
    display_try_again
  end

  def display_try_again
    sleep(1.5)
    display_message("Click New Game to try again or Exit")
    start_button.enable
  end

  def close
    stage.close
  end

end