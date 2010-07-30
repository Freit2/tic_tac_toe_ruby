module BoardType

  def mouse_clicked(e)
    boards = TTT::CONFIG.boards
    if self.id.match(boards.keys.first.to_s)
      board = boards.keys.first
      other_board = boards.keys.last if boards.keys.size == 2
    else
      board = boards.keys.last
      other_board = boards.keys.first
    end
    production.board_selection = board.to_s
    style.background_image = "images/props/#{boards[board][:on]}"
    if boards.keys.size == 2
      scene.find("board_#{other_board.to_s}").style.background_image = "images/props/#{boards[other_board][:off]}"
    end
  end
end