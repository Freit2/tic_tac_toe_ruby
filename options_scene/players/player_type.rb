module PlayerType

  def mouse_clicked(e)
    piece = self.id =~ /_o_/ ? 'o' : 'x'
    production.players.each do |pl|
      if self.id.match(pl[:id])
        style.background_image = "images/props/#{pl[:on]}"
        production.player_selection.each do |player|
          if player[:id] == piece
            player[:name] = pl[:id]
            player[:value] = pl[:value]
          end
        end
      else
        scene.find("player_#{piece}_#{pl[:id]}").style.background_image =
          "images/props/#{pl[:off]}"
      end
    end
  end
end