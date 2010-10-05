module UI
  def display_board(board)
  end

  def display_message(image=nil)
    @status = image
  end

  def human_player_move(piece)
    display_message("/images/messages/move_player_#{piece.downcase}.png")
  end

  def display_cpu_move_message(piece)
  end

  def display_winner(winner)
    display_message("/images/end_message/winner_#{winner.downcase}.png")
  end

  def display_draw_message
    display_message("/images/end_message/draw_game.png")
  end

  def display_scores(s)
  end

  def display_try_again
  end
end
