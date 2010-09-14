module GameHelper
  def options_for_board
    options = ""
    TTT::CONFIG.boards.active.each do |board|
      if board == @board_selection
        options += "<option selected=\"selected\">#{board}</option>"
      else
        options += "<option>#{board}</option>"
      end
    end
    return options
  end

  def options_for_player(default_selection)
    options = ""
    TTT::CONFIG.players.values.each do |hash|
      if hash[:value] == default_selection
        options += "<option selected=\"selected\">#{hash[:value]}</option>"
      else
        options += "<option>#{hash[:value]}</option>"
      end
    end
    return options
  end
end
