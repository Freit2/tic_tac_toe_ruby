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
  button :id => 'start_button', :action => "scene.play_new_game"
  button :id => 'exit_button', :action => "scene.close"
end