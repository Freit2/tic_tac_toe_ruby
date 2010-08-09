scoreboard_scene {
  background_image "/../../assets/images/background/score_board.jpg"
  background_image_fill_strategy :static
  background_image_x :center
  background_image_y :center
  width '100%'
  height '100%'
}

gap {
  height 160
  width '100%'
}

menu {
  width '100%'
  vertical_alignment :bottom
  bottom_padding 20
}

label {
  left_margin 20
  width '35%'
}

player_score {
  width '20%'
  font_face :georgia
  font_size 20
}

mini_gap {
  height 80
  width '100%'
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
  background_image "/../../assets/images/props/ok_dim.png"
  hover {
    background_image "/../../assets/images/props/ok.png"
  }
}
