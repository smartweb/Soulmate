class Stage0 < StageVC

  def loadView
    super
    self.view       = StageView.stage

    @goto           = GotoBtn.goto 1
    self.view << @goto

    @title          = Item.label([[162, 93], [700, 220]], 37, true)
    @title.text     = 'What if everyone actually had only one soul mate, a random person somewhere in the world?'
    self.view << @title

    @actor          = Item.item([[416, 318], [74, 157]], 'stage0_actor')
    @actor.alpha    = 0.0
    self.view << @actor

    @actress        = Item.item([[540, 318], [69, 157]], 'stage0_actress')
    @actress.alpha  = 0.0
    self.view << @actress
  end

  def viewDidLoad
    super
    @line_0 = make_line(0, self)
  end

  def viewDidAppear(animated)
    super
    @line_0.play

    animation_make(
      lambda { @actor.alpha = 1.0 },
      nil, 0.5
    )

    animation_make(
      lambda { @actress.alpha = 1.0 },
      nil, 0.5, 2.0
    )
  end

  def viewDidDisappear(animated)
    super
    @line_0.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    puts 'Stage 0 finished!'
    App.delegate.open_stage(1)
  end

end