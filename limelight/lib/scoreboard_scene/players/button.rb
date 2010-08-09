module Button

  attr_accessor :action

  def mouse_clicked(e)
    instance_eval(@action)
  end

end
