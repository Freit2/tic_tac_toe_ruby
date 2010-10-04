module OptionsScene

  prop_reader :start_button, :exit_button

  def scene_opened(e)
    build_scene
    initialize_board_option
    initialize_player_options
    initialize_buttons
    initialize_prop_defaults
  end

  def close
    stage.close
  end

# TODO: contains monkey patch until LL bug is fixed with hover.background_image
  def build_scene
    boards = TicTacToeEngine::TTT::CONFIG.boards
    scene.build do
      menu do
        label
        board_selection do
          boards.keys.each do |key|
            if boards[key][:active]
              if key == :'3x3'
                board_3x3 :id => 'board_3x3', :players => 'board_type'
              end
              if key == :'4x4'
                board_4x4 :id => 'board_4x4', :players => 'board_type'
              end
            end
          end
        end
      end
      __install "options_scene/partial_options.rb"
    end
  end

  def initialize_board_option
    TicTacToeEngine::TTT::CONFIG.boards.keys.each do |key|
      if TicTacToeEngine::TTT::CONFIG.boards[key][:active]
        prop = find("board_#{key.to_s}")
        prop.style.background_image = "#{production.images_path}/props/#{TicTacToeEngine::TTT::CONFIG.boards[key][:off]}"
        prop.hover_style.background_image = "#{production.images_path}/props/#{TicTacToeEngine::TTT::CONFIG.boards[key][:on]}"
      end
    end
  end

  def initialize_player_options
    TicTacToeEngine::TTT::CONFIG.pieces.values.each do |p|
      TicTacToeEngine::TTT::CONFIG.players.keys.each do |key|
        prop = find("player_#{p.downcase}_#{key.to_s}")
        prop.style.background_image = "#{production.images_path}/props/#{TicTacToeEngine::TTT::CONFIG.players[key][:off]}"
        prop.hover_style.background_image = "#{production.images_path}/props/#{TicTacToeEngine::TTT::CONFIG.players[key][:on]}"
      end
    end
  end

  def initialize_buttons
    start_button.style.background_image = "#{production.images_path}/props/new_game_dim.jpg"
    start_button.hover_style.background_image = "#{production.images_path}/props/new_game.jpg"
    exit_button.style.background_image = "#{production.images_path}/props/exit_dim.jpg"
    exit_button.hover_style.background_image = "#{production.images_path}/props/exit.jpg"
  end

  def initialize_prop_defaults
    find("board_#{production.board_selection}").mouse_clicked(nil)
    find("player_o_#{production.player_selection.first[:name]}").mouse_clicked(nil)
    find("player_x_#{production.player_selection.last[:name]}").mouse_clicked(nil)
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
