class Stage8 < StageVC

  AC = {
      :view => {
          :frame => CGRectMake(0, 0, 1024, 576)
      },
      :actor => {
          :start => CGRectMake(304, 195, 120, 300),
          :end => CGRectMake(304, 358, 55, 137)
      },
      :actress => {
          :start => CGRectMake(635, 195, 120, 300),
          :end => CGRectMake(700, 358, 55, 137)
      },
      :fake_love => {
          :start => CGRectMake(515, 273, 30, 30),
          :middle => CGRectMake(515, 157, 30, 30),
          :end => CGRectMake(260, 36, 504, 504)
      },
      :ending => {
          :frame => CGRectMake(212, 38, 600, 500)
      }
  }

  def loadView
    super
    self.view = StageView.stage

    @goto = GotoBtn.goto 9
    self.view << @goto

    # scene 1
    @scene1 = UIView.alloc.initWithFrame(AC[:view][:frame])
    @scene1.backgroundColor = UIColor.whiteColor

    @actor = Item.item(AC[:actor][:start], 'stage8_actor')
    @scene1 << @actor

    @actress = Item.item(AC[:actress][:start], 'stage8_actress')
    @scene1 << @actress

    @fake_love = Item.item(AC[:fake_love][:start], 'stage8_fakelove')
    @fake_love.alpha = 0.0
    @scene1 << @fake_love

    self.view << @scene1

    # scene 2
    @scene2 = UIView.alloc.initWithFrame(AC[:view][:frame])
    @scene2.backgroundColor = UIColor.whiteColor

    @photo = Item.item([[262, 38], [500, 500]], 'stage8_photo')
    @scene2 << @photo

    # scene 3
    @scene3 = UIView.alloc.initWithFrame(AC[:view][:frame])
    @scene3.backgroundColor = UIColor.whiteColor

    @ending1 = Item.item(AC[:ending][:frame], 'stage8_ending_1')
    @scene3 << @ending1

    @ending3 = Item.item(AC[:ending][:frame], 'stage8_ending_3')
    @ending3.alpha = 0.0
    @scene3 << @ending3

    @ending2 = Item.item(AC[:ending][:frame], 'stage8_ending_2')
    @ending2.alpha = 0.0
    @scene3 << @ending2

    @ending4 = Item.item(AC[:ending][:frame], 'stage8_ending_4')
    @ending4.alpha = 0.0
    @scene3 << @ending4

    @left_heart = Item.item([[340, 9], [250, 250]], 'stage8_ending_3_left')
    @left_heart.alpha = 0.0
    @scene3 << @left_heart

    @right_heart = Item.item([[460, 9], [250, 250]], 'stage8_ending_3_right')
    @right_heart.alpha = 0.0
    @scene3 << @right_heart
  end

  def viewDidLoad
    super

    @line_26 = make_line(26, self)
    @line_27 = make_line(27, self)
    @line_28 = make_line(28, self)
    @line_28_1 = make_line('28.1', self)
    @line_29 = make_line(29, self)
  end

  def viewDidAppear(animated)
    super
    @line_26.play

    fake_love_shake
  end

  def fake_love_shake
    NSTimer.scheduledTimerWithTimeInterval(1.0,
                                           target:self,
                                           selector:'shake_heart',
                                           userInfo:nil,
                                           repeats:true)
  end

  def shake_heart
    @fake_love.shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation' unless @fake_love.nil?
  end

  def left_love_shake
    NSTimer.scheduledTimerWithTimeInterval(1.0,
                                           target:self,
                                           selector:'left_shake',
                                           userInfo:nil,
                                           repeats:true)
  end

  def left_shake
    @left_heart.shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation' unless @left_heart.nil?
  end

  def right_love_shake
    NSTimer.scheduledTimerWithTimeInterval(1.0,
                                           target:self,
                                           selector:'right_shake',
                                           userInfo:nil,
                                           repeats:true)
  end

  def right_shake
    @right_heart.shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation' unless @right_heart.nil?
  end

  def scene3_perform
    animation_make(lambda { @ending1.alpha = 1.0 })
    animation_make(lambda { @ending2.alpha = 1.0 }, nil, 0.5, 1.0)
    animation_make(lambda { 
      @ending3.alpha = 1.0
      @left_heart.alpha = 1.0
      @right_heart.alpha = 1.0
    }, lambda { | finished|
      left_love_shake
      right_love_shake
    }, 0.5, 2.0)
  end

  def viewDidDisappear(animated)
    super
    @line_26.stop
    @line_27.stop
    @line_28.stop
    @line_28_1.stop
    @line_29.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    case player
      when @line_26
        @line_27.play
        animation_make(lambda {
          @fake_love.alpha = 1.0
          @actor.frame = AC[:actor][:end]
          @actress.frame = AC[:actress][:end]
          @fake_love.frame = AC[:fake_love][:end]
        })
      when @line_27
        @line_28.play
        UIView.transitionFromView(@scene1,
                           toView:@scene2,
                         duration:0.5,
                          options:UIViewAnimationOptionTransitionNone,
                       completion:nil)
      when @line_28
        @line_28_1.play
        UIView.transitionFromView(@scene2,
                           toView:@scene3,
                         duration:0.5,
                          options:UIViewAnimationOptionTransitionNone,
                       completion:lambda { |finished| scene3_perform })
      when @line_28_1
        @line_29.play
        animation_make(lambda { @ending4.alpha = 1.0 })
      when @line_29
        puts 'Stage 8 finished!'
        App.delegate.open_stage(9)
    end
  end

end