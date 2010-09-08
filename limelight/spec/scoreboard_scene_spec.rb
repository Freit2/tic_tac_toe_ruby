require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Scoreboard Scene" do

  uses_scene "scoreboard_scene", :hidden => true

  before(:each) do
    production.production_loaded
  end

  it "should receive message for start" do
    scene.should_receive(:display_scores)

    scene.start
  end

  it "should receive messages for open_board" do
    scene.should_receive(:open_board_scene)
    scene.stage.should_receive(:hide)

    scene.open_board
  end

  it "should receive message for open_board_scene" do
    production.theater["board"].should_receive(:show)

    scene.open_board_scene
  end

  it "should display scores" do
    scene.display_scores

    scene.find('player_x_wins').text.to_i.should >= 0
    scene.find('player_x_losses').text.to_i.should >= 0
    scene.find('player_x_draws').text.to_i.should >= 0
    scene.find('player_o_wins').text.to_i.should >= 0
    scene.find('player_o_losses').text.to_i.should >= 0
    scene.find('player_o_draws').text.to_i.should >= 0
  end
end
