# This file, (styles.rb) inside a scene, should define any styles specific to the containing scene.
# It makes use of the StyleBuilder DSL.
#
# For more information see: http://limelightwiki.8thlight.com/index.php/A_Cook%27s_Tour_of_Limelight#Styling_with_styles.rb
# For a complete listing of style attributes see: http://limelightwiki.8thlight.com/index.php/Style_Attributes

default_scene {
  background_color :white
  secondary_background_color :black
  gradient :on
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  height "100%"
}

menu {
  width '100%'
  horizontal_alignment :center
  vertical_alignment :bottom
  bottom_padding 20
}

label {
  font_size 20
  font_face :arial
  font_style :bold
  text_color "#2661da"
  right_margin 20
}

player_selection {
  width 150
}

menu_item {
  width 100
  right_margin 20
  padding 10
  border_color :white
  border_width 1
  rounded_corner_radius 5
  text_color "#2661da"
  font_size 20
  font_face :arial
  font_style :bold
  horizontal_alignment :center
  hover {
    background_color :light_grey
  }
}

row {
  width '100%'
  horizontal_alignment :center
  vertical_alignment :bottom
}

square {
  height 130
  width 130
  border_color :white
  border_width 1
  horizontal_alignment :center
  vertical_alignment :bottom
  gradient :on
  font_size 120
  hover {
    background_color :green
    border_width 1
  }
}