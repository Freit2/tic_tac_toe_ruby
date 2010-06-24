# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

menu do
  label :text => 'Player 1'
  player :players => 'combo_box', :choices => ['human', 'semi-weak cpu', 'unbeatable cpu'], :value => 'human'
end

menu do
  label :text => 'Player 2'
  player :players => 'combo_box', :choices => ['human', 'semi-weak cpu', 'unbeatable cpu'], :value => 'unbeatable cpu'
end

menu do
  menu_item :text => "Start", :action => "scene.start"
  menu_item :text => "Exit", :action => "scene.close"
end

row do
  square :id => "square_0"
  square :id => "square_1"
  square :id => "square_2"
end

row do
  square :id => "square_3"
  square :id => "square_4"
  square :id => "square_5"
end

row do
  square :id => "square_6"
  square :id => "square_7"
  square :id => "square_8"
end