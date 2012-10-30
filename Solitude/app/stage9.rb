class Stage9 < StageVC

  def loadView
    super
    self.view       = StageView.stage

    @goto           = GotoBtn.goto 0
    self.view << @goto

    @actor          = Item.item([[416, 318], [74, 157]], 'stage0_actor')
    self.view << @actor
  end

  def viewDidLoad
    super
    @line_30 = make_line(30, self)
  end

  def viewDidAppear(animated)
    super
    @line_30.play
  end

  def viewDidDisappear(animated)
    super
    @line_30.stop
    App.delegate.bgm.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    puts 'Stage 9 finished!'
  end

end