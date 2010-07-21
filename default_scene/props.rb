# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

status :id => 'status'

menu do
  label :text => 'board'
  board_selection :id => 'board_selection', :players => 'combo_box',
                  :choices => ['3x3', '4x4'], :value => '3x3'
end

menu do
  label :text => 'player O'
  player_selection :id => 'player_o_type', :players => 'combo_box',
                   :choices => ['human', 'easy cpu', 'medium cpu', 'unbeatable cpu'], :value => 'human'
end

menu do
  label :text => 'player X'
  player_selection :id => 'player_x_type', :players => 'combo_box',
                   :choices => ['human', 'easy cpu', 'medium cpu', 'unbeatable cpu'], :value => 'unbeatable cpu'
end

menu do
  menu_item :id => 'start_button', :text => "new game", :action => "scene.play_new_game"
  menu_item :id => 'exit_button', :text => "exit", :action => "scene.close"
end