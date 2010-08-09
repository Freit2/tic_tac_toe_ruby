gap

menu do
  label
  player_score :id => 'player_o_wins'
  player_score :id => 'player_o_losses'
  player_score :id => 'player_o_draws'
end

menu do
  label
  player_score :id => 'player_x_wins'
  player_score :id => 'player_x_losses'
  player_score :id => 'player_x_draws'
end

mini_gap

button_menu do
  button :id => 'ok_button', :players => 'button', :action => "scene.open_board"
end
