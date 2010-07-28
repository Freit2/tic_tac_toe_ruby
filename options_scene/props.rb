menu do
  label :text => ''
  board_selection :id => 'board_selection', :players => 'combo_box'
end

menu do
  label :text => ''
  player_selection :id => 'player_o_type', :players => 'combo_box'
end

menu do
  label :text => ''
  player_selection :id => 'player_x_type', :players => 'combo_box'
end

button_menu do
  start_button :id => 'start_button', :players => 'button',
    :action => "scene.play_new_game",
    :background_image => "images/props/new_game_dim.jpg"
  exit_button :id => 'exit_button', :players => 'button',
    :action => "scene.close",
    :background_image => "images/props/exit_dim.jpg"
end