module Square
  def mouse_clicked(event)
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
