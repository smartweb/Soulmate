class Stage4 < StageVC

  AC = {
      :sun => {
          :start => CGRectMake(904, 576, 100, 100),
          :end   => CGRectMake(904, 20, 100, 100),
          :rotation => Math::PI / 2
      },
      :timeline => {
          :past => CGRectMake(0, 0, 3417, 576),
          :present => CGRectMake(-1330, 0, 3417, 576),
          :future => CGRectMake(-2485, 0, 3417, 576)
      },
      :ancient => {
          :start => CGRectMake(284, 122, 150, 320),
          :end   => CGRectMake(327, 226, 69, 149)
      },
      :present => {
          :start => CGRectMake(442, 122, 150, 320),
          :end   => CGRectMake(409, 226, 68, 148)
      },
      :future => {
          :start => CGRectMake(600, 122, 150, 320)
      }
  }

  def loadView
    super
    self.view = StageView.stage

    @goto = GotoBtn.goto 5
    self.view << @goto

    @time_line = Item.item(AC[:timeline][:past], 'stage4_timeline')
    self.view << @time_line

    @soul_of_soul = Item.item([[12, 148], [1000, 280]], 'stage4_sss')
    @soul_of_soul.alpha = 0.0
    self.view << @soul_of_soul

    @amaze = Item.item([[312, 183], [80, 60]], 'stage4_amaze')
    @amaze.alpha = 0.0
    self.view << @amaze

    @ancient = Item.item(AC[:ancient][:start], 'stage4_ancient')
    @ancient.alpha = 0.0
    self.view << @ancient

    @present = Item.item(AC[:present][:start], 'stage4_present')
    @present.alpha = 0.0
    self.view << @present

    @future = Item.item(AC[:future][:start], 'Stage4_future')
    @future.alpha = 0.0
    self.view << @future
  end

  def viewDidLoad
    super

    @line_11 = make_line(11, self)
    @line_11_1 = make_line('11.1', self)
    @line_12 = make_line(12, self)
    @line_12_1 = make_line('12.1', self)
    @line_13 = make_line(13, self)
    @marimba = make_line('marimba', self)
  end

  def viewDidAppear(animated)
    super
    @line_11.play

    timeline_animate(AC[:timeline][:present], 2.5)
  end

  def viewDidDisappear(animated)
    super
    @line_11.stop
    @line_11_1.stop
    @line_12.stop
    @line_12_1.stop
    @line_13.stop
    @marimba.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    case player
      when @line_11
        timeline_animate(AC[:timeline][:future], 2.0)
        @line_11_1.play
      when @line_11_1
        animation_make(lambda {@time_line.alpha = 0.0; @ancient.alpha = 1.0})
        @line_12.play
      when @line_12
        animation_make(lambda {@future.alpha = 1.0})
        @line_12_1.play
      when @line_12_1
        animation_make(lambda {@present.alpha = 1.0})
        animation_make(lambda {
          @future.alpha = 0.0
          @present.frame = AC[:present][:end]
          @ancient.frame = AC[:ancient][:end]
        }, lambda {|finished| animation_make(lambda {
          @soul_of_soul.alpha = 1.0
          @present.alpha = 0.0
          @ancient.alpha = 0.0
        })}, 0.3, 1.0)
        @line_13.play
      when @line_13
        @marimba.play
        animation_make(lambda {@amaze.alpha = 1.0},
                       nil, 0.0, 0.5)
      when @marimba
        puts 'Stage 4 finished!'
        App.delegate.open_stage(5)
    end
  end

  def timeline_animate(position, delay=0.0)
    animation_make(lambda {
      @time_line.frame = position
    }, nil, 0.5, delay, UIViewAnimationOptionCurveEaseIn)
  end

end