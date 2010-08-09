class Scoreboard
  attr_accessor :scores

  def initialize
    @scores = {:o => { :wins => 0, :draws => 0, :losses => 0},
                    :x => { :wins => 0, :draws => 0, :losses => 0}}
  end

  def loser(piece)
    piece == 'X' ? 'O' : 'X'
  end

  def add_score(winner)
    if winner
      @scores[winner.downcase.to_sym][:wins] += 1
      @scores[loser(winner).downcase.to_sym][:losses] += 1
    else
      @scores[:o][:draws] += 1
      @scores[:x][:draws] += 1
    end
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
