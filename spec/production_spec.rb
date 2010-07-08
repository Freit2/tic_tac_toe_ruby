require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Production" do

  uses_scene "game_scene", :hidden => true, :stage => "default"

  it "should load require libraries" do
    production.should_receive(:require).exactly(3).times
    production.production_opening
  end
end