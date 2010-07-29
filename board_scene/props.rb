# This file (props.rb) defines all the props that appear in a scene when loaded.  It makes use of the
# PropBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#PropBuilder_DSL

menu do
  quit :id => 'quit', :players => 'button', :action => "scene.close"
end

gap

menu do
  status :id => 'status'
end