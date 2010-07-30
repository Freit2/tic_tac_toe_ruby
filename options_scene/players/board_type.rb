module BoardType

  def mouse_clicked(e)
    boards = production.boards
    if self.id.match(boards.first[:id])
      board = boards.first
      other_board = boards.last if boards.size == 2
    else
      board = boards.last
      other_board = boards.first
    end
    production.board_selection = board[:id]
    style.background_image = "images/props/#{board[:on]}"
    if boards.size == 2
      scene.find("board_#{other_board[:id]}").style.background_image = "images/props/#{other_board[:off]}"
    end
  end
end