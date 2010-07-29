module BoardType

  def mouse_clicked(e)
    if self.id.match(production.boards.first[:id])
      board = production.boards.first
      other_board = production.boards.last
    else
      board = production.boards.last
      other_board = production.boards.first
    end
    production.board_selection = board[:id]
    style.background_image = "images/props/#{board[:on]}"
    scene.find("board_#{other_board[:id]}").style.background_image = "images/props/#{other_board[:off]}"
  end
end