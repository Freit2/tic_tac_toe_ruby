# This file (stages.rb) is used to define the stages within your production.

stage "options" do
  default_scene "options_scene"
  location [:center, :center]
  size [505, 380]
  framed false
end

stage "board" do
  location [:center, :center]
  size [825, 700]
  framed false
end

stage "scoreboard" do
  #default_scene "scoreboard_scene"
  location [:center, :center]
  size [505, 380]
  framed false
end

#stage "devtool" do
#  default_scene "devtool"
#  title "Dev Tool"
#  location [50, 25]
#  size [100, 100]
#  background_color "transparent"
#  framed false
#end
