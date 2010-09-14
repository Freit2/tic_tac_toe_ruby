class GameController < ApplicationController

  def new
    TTT.initialize_cache
puts "Game#new"
time = Time.now.to_s
puts time
cookies[:the_time] = time
  end

  def start
puts "Game#start"
puts "[#{cookies[:the_time]}]"
  end
end
