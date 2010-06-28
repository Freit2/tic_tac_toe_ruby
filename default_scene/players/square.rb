module Square

  attr_reader :enabled

  def casted
    @enabled = false
    disable
  end

  def mouse_clicked(e)
    if @enabled && scene.player_allowed && self.text == ' '
      self.text = scene.current_player.piece
      if self.text == 'X'
        self.style.text_color = :blue
      else
        self.style.text_color = :red
      end
      (0..8).each do |s|
        if self.id == "square_#{s}"
          scene.move = s
        end
      end
    end
  end

  def disable
    @enabled = false
    self.style.text_color = "grey"
    @tmp_hover_style = hover_style if hover_style
    self.hover_style = nil
  end

  def enable
    self.hover_style = @tmp_hover_style if @tmp_hover_style
    @enabled = true
  end

end
