# This file (stages.rb) is used to define the stages within your production.

stage "default" do
  title "Limelight Tic Tac Toe"
  location [:center, :center]
  size [825, 700]
end

stage "options" do
  default_scene "options_scene"
  location [:center, :center]
  size [505, 380]
  framed false
end