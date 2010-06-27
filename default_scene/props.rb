# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

menu do
  label :text => 'Player O'
  player_selection :id => 'player_o_type', :players => 'combo_box',
                   :choices => @players, :value => @player_o_def
end

menu do
  label :text => 'Player X'
  player_selection :id => 'player_x_type', :players => 'combo_box',
                   :choices => @players, :value => @player_x_def
end

menu do
  menu_item :text => "Start", :id => 'start_button', :action => "scene.start"
  menu_item :text => "Exit", :id => 'exit_button', :action => "scene.close"
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