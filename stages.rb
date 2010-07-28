# This file (stages.rb) is used to define the stages within your production.

stage "options" do
  default_scene "options_scene"
  location [:center, :center]
  size [505, 380]
  framed false
end

stage "board" do
  #default_scene "board_scene"
  title "Limelight Tic Tac Toe"
  location [:center, :center]
  size [825, 700]
end