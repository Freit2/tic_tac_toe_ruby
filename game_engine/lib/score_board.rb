class ScoreBoard
  attr_reader :score_hash
  attr_accessor :ui

  def initialize
    @score_hash = { :o => { :wins => 0, :draws => 0, :losses => 0},
                    :x => { :wins => 0, :draws => 0, :losses => 0} }
  end

  def loser(piece)
    piece == 'X' ? 'O' : 'X'
  end

  def add_score(winner)
    if winner
      @score_hash[winner.downcase.to_sym][:wins] += 1
      @score_hash[loser(winner).downcase.to_sym][:losses] += 1
    else
      @score_hash[:o][:draws] += 1
      @score_hash[:x][:draws] += 1
    end
  end

  def wins(player)
    return @score_hash[player.to_sym][:wins]
  end

  def losses(player)
    return @score_hash[player.to_sym][:losses]
  end

  def draws(player)
    return @score_hash[player.to_sym][:draws]
  end

  def display_scores
    @ui.display_scores
  end
end
