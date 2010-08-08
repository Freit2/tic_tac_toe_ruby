gap

menu do
  label
  player_score :id => 'player_o_wins', :text => "8"
  player_score :id => 'player_o_losses', :text => "7"
  player_score :id => 'player_o_draws', :text => "6"
end

menu do
  label
  player_score :id => 'player_x_wins', :text => "5"
  player_score :id => 'player_x_losses', :text => "4"
  player_score :id => 'player_x_draws', :text => "3"
end

mini_gap

button_menu do
  button :id => 'ok_button', :text => 'OK', :players => 'button', :action => "scene.close"
end
