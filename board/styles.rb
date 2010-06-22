# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

board {
  gradient :on
  background_color :white
  horizontal_alignment :center
  vertical_alignment :bottom
  bottom_margin 40
  width "100%"
  height "100%"
}

row {
  width '100%'
  horizontal_alignment :center
}

square {
  height 130
  width 130
  border_color :black
  border_width 1
  horizontal_alignment :center
  vertical_alignment :center
  gradient :on
  font_size 120
  hover {
    background_color :white
    border_width 1
    border_color :black
  }
}
