module OptionsScene

  prop_reader :start_button, :exit_button

  def scene_opened(e)
    initialize_board_option
    initialize_player_options
    initialize_buttons
    initialize_prop_defaults
  end

  def close
    stage.close
  end

  def initialize_prop_defaults
    find("board_#{production.board_selection}").mouse_clicked(nil)
    find("player_o_#{production.player_selection.first[:name]}").mouse_clicked(nil)
    find("player_x_#{production.player_selection.last[:name]}").mouse_clicked(nil)
  end

  def initialize_board_option
    production.boards.each do |pl|
      prop = find("board_#{pl[:id]}")
      prop.style.background_image = "images/props/#{pl[:off]}"
      prop.hover_style.background_image = "images/props/#{pl[:on]}"
    end
  end

  def initialize_player_options
    %w(o x).each do |p|
      production.players.each do |pl|
        prop = find("player_#{p}_#{pl[:id]}")
        prop.style.background_image = "images/props/#{pl[:off]}"
        prop.hover_style.background_image = "images/props/#{pl[:on]}"
      end
    end
  end

  def initialize_buttons
    start_button.style.background_image = "images/props/new_game_dim.jpg"
    start_button.hover_style.background_image = "images/props/new_game.jpg"
    exit_button.style.background_image = "images/props/exit_dim.jpg"
    exit_button.hover_style.background_image = "images/props/exit.jpg"
  end

  def open_board_scene
    production.producer.open_scene("board_scene", production.theater["board"])
    production.theater["board"].show if !production.theater["board"].visible?
    production.theater["board"].current_scene.start
  end

  def play_new_game
    open_board_scene
    stage.hide
  end
end