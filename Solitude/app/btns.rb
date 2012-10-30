class GotoBtn < UIButton

  def self.goto(stage)
    goto = GotoBtn.buttonWithType(UIButtonTypeCustom)
    goto.frame = [[960, 610], [44, 44]]
    img = UIImage.imageNamed('goto_btn_w')
    goto.setImage(img, forState:UIControlStateNormal)
    goto.when(UIControlEventTouchUpInside) do
      App.delegate.open_stage(stage)
    end
    goto
  end

end



class BackBtn < UIButton
  
  def self.back
    back = BackBtn.buttonWithType(UIButtonTypeCustom)
    back.frame = [[20, 610], [44, 44]]
    img = UIImage.imageNamed('back_btn_w')
    back.setImage(img, forState:UIControlStateNormal)
    back.when(UIControlEventTouchUpInside) do
      App.delegate.pop
    end
    back
  end

end