class Stage3 < StageVC

  AC = {
      :lunar => {
          :start => CGRectMake(20, 576, 100, 100),
          :end   => CGRectMake(20, 20, 100, 100)
      },
      :sun => {
          :start => CGRectMake(904, 576, 100, 100),
          :end   => CGRectMake(904, 20, 100, 100),
          :rotation => Math::PI / 2
      },
      :death => {
          :start => CGRectMake(687, 16, 0, 111),
          :end   => CGRectMake(67, 16, 620, 111)
      },
      :scroll => {
          :start => CGRectMake(0, 180, 3610, 192),
          :end   => CGRectMake(-3610 + 1024, 180, 3610, 192)
      },
      :skull => [
          [1376, 257],
          [1376, 407],
          [1311, 667],
          [691, 1367],
          [271, 1367],
          [-179, 1367],
          [-300, 800]
      ]
  }

  def loadView
    super
    self.view = StageView.stage

    @darkness = UIView.alloc.initWithFrame([[0, 0], [1024, 704]])
    @darkness.backgroundColor = UIColor.blackColor
    self.view << @darkness

    @goto = GotoBtn.goto 4
    self.view << @goto

    @lunar = Item.item(AC[:lunar][:start], 'stage3_lunar')
    self.view << @lunar

    @sun = Item.item(AC[:sun][:start], 'stage3_sun')
    self.view << @sun

    @scene1 = Item.item([[262, 41], [500, 500]], 'stage3_scene1')
    @scene1.alpha = 0.0
    self.view << @scene1

    @scene2_100b = UIView.alloc.initWithFrame([[162, 216], [700, 144]])
    @scene2_100b.alpha = 0.0
    @scene2_bar = Item.item([[0, 0], [700, 144]], 'stage3_scene2_100b')
    @scene2_label = Item.label([[239, 46], [222, 52]], 44, true)
    @scene2_label.text = '100 billion'
    @scene2_death_shadow = UIImageView.alloc.initWithImage(UIImage.imageNamed('stage3_scene2_death').resizableImageWithCapInsets([0, 0, 0, 40]))
    @scene2_death_shadow.frame = AC[:death][:start]
    @scene2_100b << @scene2_bar
    @scene2_100b << @scene2_label
    @scene2_100b << @scene2_death_shadow
    self.view << @scene2_100b

    7.times do |index|
      skull = Item.item([[730 - index * (150 - 61), 213], [150, 150]], 'skull')
      skull.alpha = 0.0
      skull.tag = 100 + index
      self.view << skull
    end

    @scene2_7b = UIView.alloc.initWithFrame([[197, 320], [320, 176]])
    @scene2_7b.alpha = 0.0
    @scene2_7b.backgroundColor = UIColor.clearColor
    @scene2_7b_quote = Item.item([[0, 0], [100, 100]], 'stage3_scene2_7b_quote')
    @scene2_7b_label = Item.label([[66, 67], [222, 52]], 44, true)
    @scene2_7b_label.text = '7 billion'
    @scene2_7b << @scene2_7b_quote
    @scene2_7b << @scene2_7b_label
    self.view << @scene2_7b

    @scene2_rate = Item.item([[712, 368], [150, 90]], 'stage3_scene2_rate')
    @scene2_rate.alpha = 0.0
    self.view << @scene2_rate

    @scroll = Item.item(AC[:scroll][:start], 'stage3_scene3')
    @scroll.alpha = 0.0
    self.view << @scroll

    @scroll_title = Item.item([[435, 166], [154, 29]], 'stage3_scene3_title')
    @scroll_title.alpha = 0.0
    self.view << @scroll_title
  end

  def viewDidLoad
    super
    view.sendSubviewToBack(@lunar)
    view.sendSubviewToBack(@sun)
    view.sendSubviewToBack(@darkness)

    @line_6 = make_line(6, self)
    @line_7 = make_line(7, self)
    @line_8 = make_line(8, self)
    @line_9 = make_line(9, self)
    @line_10 = make_line(10, self)
  end

  def viewWillAppear(animated)
    super

    lunar_shake
    sun_spin

    NSTimer.scheduledTimerWithTimeInterval(4.0,
                                           target:self,
                                           selector: 'lunar_shake',
                                           userInfo:nil,
                                           repeats:true)
  end

  def viewDidAppear(animated)
    super

    UIView.animateWithDuration(0.3, animations:lambda {
      @lunar.frame = AC[:lunar][:end]
    })

    @line_6.play

    animation_make(lambda { @scene1.alpha = 1.0 })
  end

  def viewDidDisappear(animated)
    super

    @line_6.stop
    @line_7.stop
    @line_8.stop
    @line_9.stop
    @line_10.stop
  end

  def viewWillDisappear(animated)
    super

    UIView.animateWithDuration(0.3, animations:lambda {
      @lunar.frame = AC[:lunar][:start]
    })
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    case player
      when @line_6
        animation_make(lambda {
          @lunar.frame = AC[:lunar][:start]
          @sun.frame = AC[:sun][:end]
          @darkness.alpha = 0.0
          @scene1.alpha = 0.0
          @scene2_100b.alpha = 1.0
        }, nil, 0.3)

        animation_make(lambda {
          @scene2_death_shadow.frame = AC[:death][:end]
        }, lambda { |finished| animation_make(lambda {@scene2_7b.alpha = 1.0}) }, 2.1, 3.2)

        add_skull

        @line_7.play
      when @line_7
        animation_make(lambda {@scene2_rate.alpha = 1.0}, nil, 0.3, 1.5)

        @line_8.play
      when @line_8
        animation_make(lambda {
          @sun.frame = AC[:sun][:start]
          @lunar.frame = AC[:lunar][:end]
          @darkness.alpha = 1.0
        }, lambda { |finished| skull_rush }, 0.3)

        animation_make(lambda {@scroll.alpha = 1.0; @scroll_title.alpha = 1.0})
        animation_make(lambda {@scroll.frame = AC[:scroll][:end]}, nil, 15.0)

        @line_9.play
      when @line_9
        @line_10.play
      when @line_10
        puts 'Stage 3 finished!'
        App.delegate.open_stage(4)
      else
        puts player.url
    end
  end

  def skull_rush
    7.times do |index|
      skull = view.viewWithTag(index + 100)
      animation_make(lambda { skull.frame = [AC[:skull][index], [300, 300]]}, nil, 0.2)
    end
  end

  def lunar_shake
    @lunar.shake offset: 0.1, repeat: 2, duration: 4.0, keypath: 'transform.rotation' unless @lunar.nil?
  end

  def sun_spin
    UIView.animateWithDuration(1.0,
                               delay:0.0,
                               options:UIViewAnimationOptionCurveLinear,
                               animations:lambda { @sun.transform = CGAffineTransformRotate(@sun.transform, AC[:sun][:rotation]) },
                               completion:lambda { |finished| sun_spin if finished })
  end

  def add_skull(count = 0)
    delay = 0.0
    delay = 3.2 if count == 0
    skull = view.viewWithTag(count + 100)

    animation_make(lambda {
      skull.alpha = 1.0
      skull.frame = [[skull.origin.x + 32, skull.frame.origin.y + 32], [86, 86]]
    },
    lambda { |finished| add_skull(count + 1) unless count > 5 }, 0.3, delay)
  end

end