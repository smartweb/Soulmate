class Item

  def self.item(frame, img_str)
    item = UIImageView.alloc.initWithImage(UIImage.imageNamed(img_str))
    item.frame = frame
    item
  end

  def self.label(frame, font_size=30, title=false)
    label = UILabel.alloc.initWithFrame(frame)
    label.font = title ? UIFont.fontWithName('AvenirNextCondensed-DemiBold', size:font_size) : UIFont.fontWithName('AvenirNextCondensed-Medium', size:font_size)
    label.textAlignment = UITextAlignmentCenter
    label.numberOfLines = 0
    label.lineBreakMode = UILineBreakModeWordWrap
    label.backgroundColor = UIColor.clearColor
    label
  end

end