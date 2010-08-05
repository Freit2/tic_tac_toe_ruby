require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Button Players" do

  uses_scene "options_scene", :hidden => true

  before(:all) do
    production.production_opening
  end

  before(:each) do
    production.production_loaded
  end

end