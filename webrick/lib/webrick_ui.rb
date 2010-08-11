module WEBrickUI
  def wait_until_game_starts
    while (!@current_player)
      sleep(0.1)
    end
  end

  def wait_for_move
    @player_allowed = true
    @move = nil
    while (@move == nil)
      sleep(0.1)
    end
    @player_allowed = false
    return @move
  end

  def wait_until_move_is_made(square)
    while(@board[square].strip == "")
      sleep(0.1)
    end
  end

  def display_board(board)
  end

  def display_message(image=nil)
    @status = image
  end

  def human_player_move(piece)
    display_message("/images/messages/move_player_#{piece.downcase}.png")
    return wait_for_move
  end

  def display_cpu_move_message(piece)
    display_message("/images/messages/player_#{piece.downcase}_moves.png")
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
