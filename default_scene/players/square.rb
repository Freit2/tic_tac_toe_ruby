module Square

  attr_reader :enabled, :animation

  def casted
    @enabled = false
    disable
  end

  def animate_move
    style.transparency = 80
    style.text_color = scene.piece_color
    self.text = scene.current_player.piece
    transparency = 80
    @animation = animate(:updates_per_second => 20) do
      transparency -= 10
      style.transparency = transparency
      @animation.stop if transparency <= 0
    end
  end

  def mouse_clicked(e)
    if @enabled && scene.player_allowed &&
      (text.strip == '' || style.transparency == "81%")
      (0...scene.board.size).each do |s|
        if self.id == "square_#{s}"
          scene.move = s
        end
      end
    end
  end

  def mouse_entered(e)
    if @enabled && scene.player_allowed && text.strip == ''
      style.transparency = 81
      style.text_color = scene.piece_color
      self.text = scene.current_player.piece
    end
  end

  def mouse_exited(e)
    #puts style.transparency
    if style.transparency == "81%"
      self.text = ""
      style.transparency = 0
    end
  end

  def disable
    @enabled = false
    style.text_color = "grey"
    @tmp_hover_style = hover_style if hover_style
    self.hover_style = nil
  end

  def enable
    self.hover_style = @tmp_hover_style if @tmp_hover_style
    @enabled = true
  end

end
