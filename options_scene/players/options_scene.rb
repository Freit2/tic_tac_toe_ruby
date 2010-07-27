module OptionsScene

  prop_reader :board_selection, :player_o_type, :player_x_type, :start_button, :exit_button

  def scene_opened(e)
    board_selection.choices = production.boards
    board_selection.value = production.board_selection
    player_o_type.choices = production.players
    player_o_type.value = production.player_o
    player_x_type.choices = production.players
    player_x_type.value = production.player_x
  end

  def close
    stage.close
  end

  def open_default_scene
    production.producer.open_scene("default_scene", production.theater["default"])
    production.theater["default"].current_scene.start
  end

  def play_new_game
    production.board_selection = board_selection.text
    production.player_o = player_o_type.text
    production.player_x = player_x_type.text

    open_default_scene
    stage.hide
  end
end