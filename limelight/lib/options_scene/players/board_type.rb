module BoardType
  def mouse_clicked(e)
    TicTacToeEngine::TTT::CONFIG.boards.keys.each do |key|
      case
      when self.id.match(key.to_s)
        style.background_image = "#{production.images_path}/props/#{TicTacToeEngine::TTT::CONFIG.boards[key][:on]}"
        production.board_selection = key.to_s
      when TicTacToeEngine::TTT::CONFIG.boards[key][:active]
        scene.find("board_#{key.to_s}").style.background_image =
          "#{production.images_path}/props/#{TicTacToeEngine::TTT::CONFIG.boards[key][:off]}"
      end
    end
  end
end
