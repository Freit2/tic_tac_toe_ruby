module DefaultScene

  attr_reader :player_o, :player_x, :board
  attr_accessor :current_player, :move
  prop_reader :status, :player_o_type, :player_x_type, :start_button, :exit_button,
              :square_0, :square_1, :square_2, :square_3, :square_4, :square_5,
              :square_6, :square_7, :square_8

  def enable_squares
    (0..8).each do |s|
      instance_eval("square_#{s}.enable")
    end
  end

  def disable_squares
    (0..8).each do |s|
      instance_eval("square_#{s}.disable")
    end
  end

  def get_player(player, piece)
    case player.text
      when 'human'
        return HumanPlayer.new(piece)
      when 'cpu'
        return CpuPlayer.new(piece)
      when 'minmax'
        return MinMaxPlayer.new(piece)
    end
  end

  def create_players
    @player_o = get_player(player_o_type, 'O')
    @player_x = get_player(player_x_type, 'X')
    @player_o.ui = self
    @player_x.ui = self
  end

  def play_new_game
    start_button.disable
    create_players
    @board = Board.new
    enable_squares
    @game_thread = Thread.new do
      begin
        @game = Game.new(@player_o, @player_x, @board, self)
        #@game.play
      rescue StandardError => e
        puts e
        puts e.backtrace
      end
    end
  end

  def wait_for_move
    @move = nil
    while (@move == nil)
      sleep(0.25)
    end
    return @move
  end

  def display_message(message)
    status.text = message
  end

  def display_cpu_move_message(piece)
    display_message("Player '#{piece}' makes a move")
  end

  def close
    stage.close
  end

end