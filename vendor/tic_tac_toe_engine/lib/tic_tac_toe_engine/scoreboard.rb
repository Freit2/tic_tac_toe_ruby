require 'yaml'

module TicTacToeEngine
  class Scoreboard
    attr_accessor :yaml_path, :scores

    def initialize(yaml_path=nil)
      @yaml_path = yaml_path || File.expand_path(File.dirname(__FILE__) + "/../../../../assets/db/scoreboard.yaml")
      @scores = {:o => { :wins => 0, :draws => 0, :losses => 0},
                 :x => { :wins => 0, :draws => 0, :losses => 0}}
      read_scores
    end

    def read_scores
      return if !File.exists?(@yaml_path)
      @scores = YAML::load_file(@yaml_path)
    end

    def loser(piece)
      piece == 'X' ? 'O' : 'X'
    end

    def add_scores(winner)
      if winner
        @scores[winner.downcase.to_sym][:wins] += 1
        @scores[loser(winner).downcase.to_sym][:losses] += 1
      else
        @scores[:o][:draws] += 1
        @scores[:x][:draws] += 1
      end
      write_scores
    end

    def write_scores
      File.delete(@yaml_path) if File.exists?(@yaml_path)
      File.open(@yaml_path, 'w') do |f|
        f.write(YAML::dump @scores)
      end      
    end

    def [](player)
      return @scores[player.to_sym]
    end

    def wins(player)
      return @scores[player.to_sym][:wins]
    end

    def losses(player)
      return @scores[player.to_sym][:losses]
    end

    def draws(player)
      return @scores[player.to_sym][:draws]
    end
  end
end
