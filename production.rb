# This file (production.rb) is the first file loaded opening a production.  It must define a module named 'Production'.
# The containing production will acquire all the behavior defined in this module.
# You may define serveral hooks and initialization steps here.

module Production

  attr_reader :boards, :players
  attr_accessor :board_selection, :player_selection, :player_o, :player_x

#  # Define this method if you want the production name to be different from the default, directory name.
#  def name
#    return Tic Tac Toe
#  end
#
  # Returns the minimum version of limelight required to run this production.  Default: "0.0.0"
  # If the version of limelight used to open this production is less than the minimum,
  # an error will be displayed (starting with version 0.4.0).
  #
  def minimum_limelight_version
    return "0.5.5"
  end

  # Hook #1.  Called when the production is newly created, before any loading has been done.
  # This is a good place to require needed files and instantiate objects in the business layer.
  def production_opening
    $: << File.expand_path(File.dirname(__FILE__) + "/lib")
    require 'game'
    require 'board'
    require 'player'
  end

#  # Hook #2.  Called after internal gems have been loaded and stages have been instantiated, yet before
#  # any scenes have been opened.
  def production_loaded
    @boards = [{:id => "3x3", :on => "3x3.jpg", :off => "3x3_dim.jpg"},
               {:id => "4x4", :on => "4x4.jpg", :off => "4x4_dim.jpg"}]
    @players = [{:id => "human", :value => "human", :on => "player_human.jpg", :off => "player_human_dim.jpg"},
                {:id => "easy", :value => "easy", :on => "player_easy_cpu.jpg", :off => "player_easy_cpu_dim.jpg"},
                {:id => "med", :value => "med", :on => "player_med_cpu.jpg", :off => "player_med_cpu_dim.jpg"},
                {:id => "hard", :value => "unbeatable", :on => "player_hard_cpu.jpg", :off => "player_hard_cpu_dim.jpg"}]
    @board_selection = @boards.first[:id]
    @player_selection = [{:id => 'o', :name => @players.first[:id], :value => @players.first[:value]},
                         {:id => 'x', :name => @players.last[:id], :value => @players.last[:value]}]
    #@player_o = @players.first[:value]
    #@player_x = @players.last[:value]
  end

#  # Hook #3.  Called when the production, and all the scenes, have fully opened.
#  def production_opened
#
#  end

#  # The system will call this methods when it wishes to close the production, perhaps when the user quits the
#  # application.  By default the production will always return true. You may override this behavior by re-implenting
#  # the methods here.
#  def allow_close?
#    return true
#  end
#
#  # Called when the production is about to be closed.
#  def production_closing
#  end
#
#  # Called when the production is fully closed.
#  def production_closed
#  end

end