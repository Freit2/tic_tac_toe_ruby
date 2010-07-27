# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

default_scene {
  background_color :white
  secondary_background_color :black
  gradient_angle 180
  gradient :on
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  height "100%"
}

status {
  width '100%'
  horizontal_alignment :center
  bottom_padding 50
  font_size 15
  font_face :helvetica
  font_style :bold
  text_color :green
}

row {
  width '100%'
  horizontal_alignment :center
  vertical_alignment :bottom
}

square {
  height 130
  width 130
  border_color "#2661da"
  border_width 1
  horizontal_alignment :center
  vertical_alignment :bottom
  gradient :on
  font_size 120
  font_face :helvetica
  background_color :white
  hover {
    background_color "#DEEFF9"
    border_width 1
  }
}