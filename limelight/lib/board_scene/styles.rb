board_scene {
  background_image "/../../assets/images/background/board.jpg"
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  width "100%"
  height "100%"
}

mini_gap {
  height 10
  width '100%'
}

gap {
  height 20
  width '100%'
}

width_gap {
  width '95%'
}

menu {
  width '100%'
  vertical_alignment :bottom
}

quit {
  height 24
  width 40
  right_margin 10
  border_width 1
  horizontal_alignment :right
  rounded_corner_radius 4
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  background_image "/../../assets/images/props/quit_dim.jpg"
  hover {
    background_image "/../../assets/images/props/quit.jpg"
  }
}

status {
  height 55
  width '100%'
  horizontal_alignment :center
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
  background_color "transparent"
  horizontal_alignment :center
  vertical_alignment :bottom
}

view_scoreboard_menu {
  extends :menu
  horizontal_alignment :center
}

view_scoreboard_button {
  height 24
  width 127
  border_width 1
  horizontal_alignment :right
  rounded_corner_radius 4
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  background_image "/../../assets/images/props/view_scoreboard_dim.jpg"
  hover {
    background_image "/../../assets/images/props/view_scoreboard.jpg"
  }
}

try_again_menu {
  extends :menu
  horizontal_alignment :center
}

try_again_status {
  height 24
  width 94
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  right_margin 10
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  background_image "/../../assets/images/props/try_again.png"
}

try_again_button {
  height 24
  width 40
  border_width 1
  horizontal_alignment :right
  rounded_corner_radius 4
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  background_image "/../../assets/images/props/yes_dim.jpg"
  hover {
    background_image "/../../assets/images/props/yes.jpg"
  }
}
