# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

board_scene {
  background_image "images/background/board.jpg"
  background_color :white
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  height "100%"
}

status {
  height 75
  width 520
  horizontal_alignment :center
  bottom_padding 50
}

row {
  width '100%'
  horizontal_alignment :center
  vertical_alignment :bottom
}

square {
  height 130
  width 130
  border_color :dim_grey
  border_width 1
  horizontal_alignment :center
  vertical_alignment :bottom
  font_size 120
  font_face :helvetica
  background_color :white
}