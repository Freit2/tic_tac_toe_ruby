module Square

  attr_reader :enabled, :animation

  def casted
    @enabled = false
    disable
  end

  def animate_move
    style.background_image = "#{production.images_path}/pieces/#{scene.current_player.piece.downcase}.png"
  end

  def mouse_clicked(e)
    if @enabled && scene.player_allowed && style.background_image =~ /dim/
      (0...scene.board.size).each do |s|
        if self.id == "square_#{s}"
          scene.move = s
        end
      end
    end
  end

  def mouse_entered(e)
    if @enabled && scene.player_allowed && style.background_image == "none"
      style.background_image = "#{production.images_path}/pieces/#{scene.current_player.piece.downcase}_dim.png"
    end
  end

  def mouse_moved(e)
    mouse_entered(e)
  end

  def mouse_exited(e)
    if @enabled && scene.player_allowed && style.background_image =~ /dim/
      style.background_image = "none"
    end
  end

  def disable
    @enabled = false
  end

  def enable
    @enabled = true
  end
end
