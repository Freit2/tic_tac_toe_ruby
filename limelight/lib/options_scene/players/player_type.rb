module PlayerType
  def mouse_clicked(e)
    piece = self.id =~ /_o_/ ? 'o' : 'x'
    TTT::CONFIG.players.keys.each do |key|
      if self.id.match(key.to_s)
        style.background_image = "#{production.images_path}/props/#{TTT::CONFIG.players[key][:on]}"
        production.player_selection.each do |player|
          if player[:id] == piece
            player[:name] = key.to_s
            player[:value] = TTT::CONFIG.players[key][:value]
          end
        end
      else
        scene.find("player_#{piece}_#{key.to_s}").style.background_image =
          "#{production.images_path}/props/#{TTT::CONFIG.players[key][:off]}"
      end
    end
  end
end