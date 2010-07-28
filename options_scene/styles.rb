options_scene {
  background_image "images/background/options.jpg"
  horizontal_alignment :center
  vertical_alignment :center
  width '100%'
  height '100%'
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
  width '50%'
}

board_selection {
  horizontal_alignment :left
  width '50%'
}

player_selection {
  width 150
  horizontal_alignment :left
  width '50%'
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