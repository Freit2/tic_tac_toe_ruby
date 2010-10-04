require 'csv'

module TicTacToeEngine
  class Scoreboard
    attr_accessor :csv_path, :scores

    def initialize(csv_path=nil)
      @csv_path = csv_path || File.expand_path(File.dirname(__FILE__) + "/../../../../assets/db/scoreboard.csv")
puts @csv_path
      @scores = {:o => { :wins => 0, :draws => 0, :losses => 0},
                 :x => { :wins => 0, :draws => 0, :losses => 0}}
      read_scores
    end

    def read_scores
      return if !File.exists?(@csv_path)
      CSV.open(@csv_path, 'r', ';') do |row|
        @scores[row[0].to_sym][:wins] = row[1].to_i
        @scores[row[0].to_sym][:draws] = row[2].to_i
        @scores[row[0].to_sym][:losses] = row[3].to_i
      end
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
      File.delete(@csv_path) if File.exists?(@csv_path)
      CSV.open(@csv_path, 'w', ';') do |writer|
        writer << ["o", @scores[:o][:wins], @scores[:o][:draws], @scores[:o][:losses]]
        writer << ["x", @scores[:x][:wins], @scores[:x][:draws], @scores[:x][:losses]]
        writer.close
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
