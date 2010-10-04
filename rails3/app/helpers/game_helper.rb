module GameHelper  
  def options_for_board
    options = ""
    TicTacToeEngine::TTT::CONFIG.boards.active.each do |board|
      if board == TicTacToeEngine::TTT::CONFIG.boards.active.first
        options += "<option selected=\"selected\">#{board}</option>"
      else
        options += "<option>#{board}</option>"
      end
    end
    return options
  end

  def options_for_player(default_selection)
    options = ""
    TicTacToeEngine::TTT::CONFIG[:players].values.each do |hash|
      if hash[:value] == default_selection
        options += "<option selected=\"selected\">#{hash[:value]}</option>"
      else
        options += "<option>#{hash[:value]}</option>"
      end
    end
    return options
  end

  def generate_quit_html
    "<form method='GET' action='/'>" +
      "<input type=\"submit\" value=\"Return to Options\" />" +
      "</form>"
  end

  def generate_status_html
    if @status
      return "<img src=\"#{@status}\" alt=\"status\" width=\"502\" height=\"75\"/>"
    end
    return ""
  end

  def generate_try_again_html
    if @board.game_over?
      return ("<form method='POST' action='/game/start'>" +
            "<input type=\"hidden\" name=\"board\" value=\"#{@request[:board]}\">" +
            "<input type=\"hidden\" name=\"player_o\" value=\"#{@request[:player_o]}\">" +
            "<input type=\"hidden\" name=\"player_x\" value=\"#{@request[:player_x]}\">" +
            "<img src=\"/images/labels/try_again.png\">" +
            "<input type=\"submit\" value=\"Yes\" />" +
          "</form>")
    end
    return ""
  end

  def generate_square_html(s)
    if @board.empty_squares.include?(s)
      a_start = "<a href=\"/game/start?s=#{s}\">"
      a_end = "</a>"
      image = "empty_square.png"
      on_mouse_over = "onmouseover=\"TTT.mouseOverSquare(this)\""
      on_mouse_out = "onmouseout=\"TTT.mouseOutSquare(this)\""
    else
      a_start = a_end = on_mouse_over = on_mouse_out = ""
      image = "#{@board[s].downcase}.png"
    end
    "#{a_start}<img border=\"1\" src=\"/images/pieces/#{image}\" " +
      "alt=\"square\" width=\"130\" height=\"130\" " +
      "#{on_mouse_over} #{on_mouse_out}/>#{a_end}"
  end

  def generate_board_html
    board_html = ""
    @board.ranges.each do |r|
      html = ""
      r.each do |s|
        html += generate_square_html(s)
      end
      board_html += "#{html}<br />"
    end
    return board_html
  end
end
