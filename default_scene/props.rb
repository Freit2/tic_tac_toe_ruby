# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

status :id => 'status'

menu do
  label :text => 'Player O'
  player_selection :id => 'player_o_type', :players => 'combo_box',
                   :choices => ['human', 'cpu', 'minmax'], :value => 'human'
end

menu do
  label :text => 'Player X'
  player_selection :id => 'player_x_type', :players => 'combo_box',
                   :choices => ['human', 'cpu', 'minmax'], :value => 'minmax'
end

menu do
  menu_item :id => 'start_button', :text => "New Game", :action => "scene.play_new_game"
  menu_item :id => 'exit_button', :text => "Exit", :action => "scene.close"
end

row do
  (0..2).each do |s|
    square :id => "square_#{s}"
  end
end

row do
  (3..5).each do |s|
    square :id => "square_#{s}"
  end
end

row do
  (6..8).each do |s|
    square :id => "square_#{s}"
  end
end