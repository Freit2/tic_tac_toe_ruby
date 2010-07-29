gap

menu do
  label
  board_selection do
    board_3x3 :id => 'board_3x3', :players => 'board_type'
    board_4x4 :id => 'board_4x4', :players => 'board_type'
  end
end

menu do
  label
  player_selection do
    player_human :id => 'player_o_human', :players => 'player_type'
    player_easy :id => 'player_o_easy', :players => 'player_type'
    player_med :id => 'player_o_med', :players => 'player_type'
    player_hard :id => 'player_o_hard', :players => 'player_type'
  end
end

menu do
  label
  player_selection do
    player_human :id => 'player_x_human', :players => 'player_type'
    player_easy :id => 'player_x_easy', :players => 'player_type'
    player_med :id => 'player_x_med', :players => 'player_type'
    player_hard :id => 'player_x_hard', :players => 'player_type'
  end
end

button_menu do
  start_button :id => 'start_button', :players => 'button', :action => "scene.play_new_game"
  exit_button :id => 'exit_button', :players => 'button', :action => "scene.close"
end