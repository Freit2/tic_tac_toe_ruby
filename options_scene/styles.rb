options_scene {
  background_image "images/background/options.jpg"
  horizontal_alignment :center
  vertical_alignment :center
  width "100%"
  height "100%"
}

menu {
  width '100%'
  vertical_alignment :bottom
  bottom_padding 20
}

label {
  font_size 14
  font_face :helvetica
  left_margin 10
  width 300
}

board_selection {
  horizontal_alignment :right
}

player_selection {
  width 150
  horizontal_alignment :right
}

button_menu {
  top_padding 45
  width '100%'
  horizontal_alignment :center
  vertical_alignment :bottom
}

button {
  height 40
  width 125
  right_margin 20
  padding 5
  border_width 2
  horizontal_alignment :center
  background_color "transparent"
  rounded_corner_radius 3
  hover {
    border_color "#2661da"
  }
}