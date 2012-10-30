class StageVC < UIViewController
  attr_accessor :current_stage

  def supportedInterfaceOrientations
    UIInterfaceOrientationMaskLandscape
  end

  def viewWillAppear(animated)
    super
    navigationController.setNavigationBarHidden(true, animated:true)
    navigationItem.title = "Stage #{@current_stage}"
  end

  def make_line(line_num, delegate)
    line_url        = NSURL.fileURLWithPath(NSBundle.mainBundle.pathForResource(line_num.to_s, ofType:'wav'))
    line            = AVAudioPlayer.alloc.initWithContentsOfURL(line_url, error:nil)
    line.prepareToPlay
    line.delegate   = delegate
    line
  end

  def animation_make(animation, completion=nil, duration=0.5, delay=0.0, options=UIViewAnimationOptionCurveLinear)
    UIView.animateWithDuration(duration, 
      delay:delay,
      options:options,
      animations:animation,
      completion:completion
    )
  end
end



class StageView < UIView

  def self.stage(color=UIColor.whiteColor)
    stage                   = UIView.alloc.initWithFrame([[0, 0], [1024, 768]])
    stage.clipsToBounds     = true
    stage.backgroundColor   = color

    black_box                   = UIView.alloc.initWithFrame([[0, 576], [1024, 448]])
    black_box.backgroundColor   = UIColor.viewFlipsideBackgroundColor
    stage << black_box

    stage
  end

end