options_scene {
  background_image "images/background/options.jpg"
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  rounded_corner_radius 25
  width '100%'
  height '100%'
}

gap {
  height 60
  width '100%'
}

menu {
  width '100%'
  vertical_alignment :bottom
  bottom_padding 10
}

label {
  left_margin 20
  width '50%'
}

board_selection {
  right_margin 20
  horizontal_alignment :left
  height 26
  width '50%'
  background_color :white
}

board_type {
  height '100%'
  width '50%'
  border_width 1
  background_color :white
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
}

board_3x3 {
  extends :board_type
  hover {}
}

board_4x4 {
  extends :board_type
  hover {}
}

player_selection {
  right_margin 20
  horizontal_alignment :left
  height 104
  width '50%'
  border_width 1
  background_color :white
}

player_type {
  height '25%'
  width '100%'
  background_color :white
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
}

player_human {
  extends :player_type
  hover {}
}

player_easy {
  extends :player_type
  hover {}
}

player_med {
  extends :player_type
  hover {}
}

player_hard {
  extends :player_type
  hover {}
}

button_menu {
  width '100%'
  horizontal_alignment :center
  vertical_alignment :bottom
}

button {
  height 40
  width 125
  right_margin 20
  padding 5
  border_width 1
  horizontal_alignment :center
  rounded_corner_radius 3
  background_color :white
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
}

start_button {
  extends :button
  hover {}
}

exit_button {
  extends :button
  hover {}
}