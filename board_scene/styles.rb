board_scene {
  background_image "images/background/board.jpg"
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  width "100%"
  height "100%"
}

gap {
  height 20
  width '100%'
}

menu {
  width '100%'
  vertical_alignment :bottom
}

quit {
  height 33
  width '100%'
  left_margin 780
  right_margin 10
  top_margin 10
  border_width 1
  horizontal_alignment :right
  rounded_corner_radius 4
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  background_image "images/props/quit_dim.jpg"
  hover {
    background_image "images/props/quit.jpg"
  }
}

status {
  height 75
  width '100%'
  horizontal_alignment :center
  bottom_padding 50
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
}

row {
  width '100%'
  horizontal_alignment :center
  vertical_alignment :bottom
}

square {
  height 130
  width 130
  border_color :black
  horizontal_alignment :center
  vertical_alignment :bottom
  background_color :white
}