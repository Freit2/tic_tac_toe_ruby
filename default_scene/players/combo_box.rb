module ComboBox
  def value_changed(e)
    combo_box_prop = scene.find()
    combo_box_prop.text = self.value
  end
end