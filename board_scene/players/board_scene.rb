module BoardScene

  attr_reader :player_o, :player_x, :animation, :thread
  attr_accessor :game, :board, :current_player, :move, :player_allowed
  prop_reader :status, :player_o_type, :player_x_type, :start_button, :exit_button

  def scene_opened(e)
    @player_allowed = false
  end

  def start
    create_board
    build_squares
    format_squares
    clear_squares
    create_players
    enable_squares
    start_game_thread
  end

  def cleanup
    @animation.stop if @animation
    remove_squares
    remove_try_again
  end

  def restart
    cleanup
    start
  end

  def open_options_scene
    production.theater["options"].show
  end

  def close
    cleanup
    open_options_scene
    stage.hide
  end

  def build_try_again
    scene.build do
      try_again_menu :id => 'try_again_menu' do
        gap
        try_again_status :id => 'try_again_status'
        try_again_button :id => 'try_again_button', :players => 'button', :action => "scene.restart"
      end
    end
  end

  def remove_try_again
    children_to_remove = []
    scene.children.each do |p|
      if p.name == "try_again_menu"
        p.children.each do |s|
          children_to_remove << s
        end
        children_to_remove << p
      end
    end
    children_to_remove.each do |p|
      scene.remove(p)
    end
  end

  def build_squares
    @board.ranges.each do |r|
      scene.build do
        row do
          r.each do |s|
            square :id => "square_#{s}", :border_width => 1
          end
        end
      end
    end
  end

  def format_squares
    ranges = @board.ranges
    ranges.each do |r|
      case
      when ranges.first == r
        r.each do |s|
          find("square_#{s}").style.top_border_width = 0
        end
      when ranges.last == r
        r.each do |s|
          find("square_#{s}").style.bottom_border_width = 0
        end
      end
      r.each do |s|
        find("square_#{s}").style.left_border_width = 0 if r.first == s
        find("square_#{s}").style.right_border_width = 0 if r.last-1 == s
      end
    end
  end

  def remove_squares
    children_to_remove = []
    scene.children.each do |p|
      if p.name == "row"
        p.children.each do |s|
          children_to_remove << s
        end
        children_to_remove << p
      end
    end
    children_to_remove.each do |p|
      scene.remove(p)
    end
  end

  def clear_squares
    (0...@board.size).each do |s|
      find("square_#{s}").text = ""
    end
  end

  def enable_squares
    (0...@board.size).each do |s|
      find("square_#{s}").enable
    end
  end

  def disable_squares
    (0...@board.size).each do |s|
      find("square_#{s}").disable
    end
  end

  def create_players
    player_o = production.player_selection.first
    player_x = production.player_selection.last
    @player_o = Player.create(player_o[:value][0,1], player_o[:id].upcase)
    @player_x = Player.create(player_x[:value][0,1], player_x[:id].upcase)
    @player_o.ui = self
    @player_x.ui = self
    cache = production.cache[TTT::CONFIG.boards[production.board_selection][:cache]]
    #puts "USING CACHE: #{TTT::CONFIG.boards[production.board_selection][:cache]}"
    @player_o.cache = cache
    @player_x.cache = cache
  end

  def create_board
    board_size = production.board_selection[0,1].to_i ** 2
    @board = Board.new(nil, board_size)
  end

  def start_game_thread
    @thread = Thread.new do
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
      sleep(0.1)
    end
    @player_allowed = false
    return @move
  end

  def display_board(board)
    find("square_#{board.last_move}").animate_move if board.last_move
  end

  def animate_win
    @animation = animate(:updates_per_second => 3) do
      @board.win_moves.each do |s|
        square = find("square_#{s}")
        square.disable
        background_image = square.style.background_image
        case
        when background_image =~ /o\.jpg/
        square.style.background_image = "images/pieces/o_dim.jpg"
        when background_image =~ /o_dim/
        square.style.background_image = "images/pieces/o.jpg"
        when background_image =~ /x\.jpg/
        square.style.background_image = "images/pieces/x_dim.jpg"
        when background_image =~ /x_dim/
        square.style.background_image = "images/pieces/x.jpg"
        end
      end
    end
  end

  def display_message(image)
    status.style.background_image = image
  end

  def get_human_player_move(piece)
    display_message("images/messages/move_player_#{piece.downcase}.jpg")
    return wait_for_move
  end

  def display_cpu_move_message(piece)
    display_message("images/messages/player_#{piece.downcase}_moves.jpg")
    sleep(0.5)
  end

  def display_winner(winner)
    display_message("images/end_message/winner_#{winner.downcase}.jpg")
    animate_win
    build_try_again
  end

  def display_draw_message
    display_message("images/end_message/draw_game.jpg")
    build_try_again
  end
end
