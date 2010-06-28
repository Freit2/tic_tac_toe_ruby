module Square

  attr_reader :enabled

  def casted
    @enabled = false
    disable
  end

  def mouse_clicked(event)
    if @enabled
      @piece = 'X'
      if self.text == ''
        self.text = @piece
        if @piece == 'X'
          self.style.text_color = :blue
        else
          self.style.text_color = :red
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
