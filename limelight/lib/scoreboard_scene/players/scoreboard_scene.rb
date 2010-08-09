module ScoreboardScene

  def scene_opened(e)
  end

  def start
    display_scores
  end

  def display_scores
    %w(o x).each do |p|
      %w(wins losses draws).each do |s|
        find("player_#{p}_#{s}").text = production.scoreboard[p][s.to_sym]
      end
    end
  end

  def open_board_scene
    production.theater["board"].show
  end

  def open_board
    open_board_scene
    stage.hide
  end

end
