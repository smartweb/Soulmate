class Stage5 < StageVC

  AC = {
      :self => {
          :start => CGRectMake(327, 128, 150, 320),
          :end => CGRectMake(7, 231, 98, 209)
      },
      :self_age => {
          :start => CGRectMake(369, 128, 100, 52),
          :end => CGRectMake(14, 207, 100, 52)
      },
      :soulmate => {
          :start => CGRectMake(547, 128, 150, 320),
          :end => CGRectMake(99, 231, 98, 209)
      },
      :soulmate_age => {
          :start => CGRectMake(544, 128, 120, 52),
          :end => CGRectMake(86, 207, 120, 52)
      },
      :diagram => {
          :start => CGRectMake(1054, 13, 800, 440),
          :end => CGRectMake(224, 13, 800, 440)
      },
      :annotation => {
          :start => CGRectMake(255, 48, 700, 500)
      }
  }

  def loadView
    super
    self.view = StageView.stage

    @goto = GotoBtn.goto 7
    self.view << @goto

    @self_avatar = Item.item(AC[:self][:start], 'stage5_self')
    self.view << @self_avatar

    @self_age = Item.label(AC[:self_age][:start], 40, true)
    self.view << @self_age

    @soulmate = Item.item(AC[:soulmate][:start], 'stage5_soulmate')
    self.view << @soulmate

    @soulmate_age = Item.label(AC[:soulmate_age][:start], 40, true)
    self.view << @soulmate_age

    @annotation = Item.item(AC[:annotation][:start], 'stage5_annotation')
    @annotation.alpha = 0.0
    self.view << @annotation

    @diagram = Item.item(AC[:diagram][:start], 'stage5_diagram')
    self.view << @diagram
  end

  def viewDidLoad
    super

    @line_14 = make_line(14, self)
    @line_15 = make_line(15, self)
    @line_16 = make_line(16, self)
  end

  def viewDidAppear(animated)
    super

    @line_14.play
  end

  def viewDidDisappear(animated)
    super
    @line_14.stop
    @line_15.stop
    @line_16.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    case player
      when @line_14
        @self_age.text = '25'
        @soulmate_age.text = '20~29'
        @line_15.play
      when @line_15
        animation_make(lambda {
          @self_avatar.frame = AC[:self][:end]
          @self_age.alpha = 0.0
          @soulmate.frame = AC[:soulmate][:end]
          @soulmate_age.alpha = 0.0
          @diagram.frame = AC[:diagram][:end]
        }, nil, 0.1)
        animation_make(lambda {@annotation.alpha = 1.0}, nil, 0.3, 1.5)
        @line_16.play
      when @line_16
        puts 'Stage 5 finished!'
        App.delegate.open_stage(7)
    end
  end

end