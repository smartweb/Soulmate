class Stage2 < StageVC

  def loadView
    super
    self.view             = StageView.stage

    @goto = GotoBtn.goto 3
    self.view << @goto

    @scene1       = Item.item([[262, 41], [500, 500]], 'stage2_scene1')
    self.view << @scene1

    @heart        = Item.item([[474, 136], [76, 76]], 'heart_middle')
    self.view << @heart

    @scene2_actor               = Item.item([[246, 169], [140, 360]], 'stage2_scene2_0_actor')
    @scene2_actor.alpha         = 0.0
    self.view << @scene2_actor

    @scene2_actress             = Item.item([[638, 169], [140, 360]], 'stage2_scene2_0_actress')
    @scene2_actress.alpha       = 0.0
    self.view << @scene2_actress

    @scene2_actor_line          = Item.label([[188, 105], [374, 41]])
    @scene2_actor_line.alpha    = 0.0
    self.view << @scene2_actor_line

    @left_quote                 = Item.item([[346, 146], [40, 50]], 'left_quote')
    @left_quote.alpha           = 0.0
    self.view << @left_quote

    @scene2_actress_line        = Item.label([[570, 105], [170, 41]])
    @scene2_actress_line.alpha  = 0.0
    self.view << @scene2_actress_line

    @right_quote                = Item.item([[630, 145], [40, 50]], 'right_quote')
    @right_quote.alpha          = 0.0
    self.view << @right_quote

    @question_mark              = Item.item([[153, -380], [718, 1336]], 'stage2_scene2_2_question')
    @question_mark.alpha        = 0.0
    self.view << @question_mark
  end

  def viewDidLoad
    super

    @line_3     = make_line(3, self)
    @line_4     = make_line(4, self)
    @line_4_1   = make_line('4.1', self)
    @line_5     = make_line(5, self)
  end

  def viewDidAppear(animated)
    super
    @line_3.play

    shake_heart(nil)
    
    NSTimer.scheduledTimerWithTimeInterval(1.0,
                                     target:self,
                                   selector:'shake_heart:',
                                   userInfo:nil,
                                    repeats:true)
  end

  def viewWillDisappear(animated)
    super
    @line_3.stop
    @line_4.stop
    @line_4_1.stop
    @line_5.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    case player
    when @line_3

      animation_make(lambda {
        @scene1.alpha               = 0.0
        @heart.alpha                = 0.0
        @scene2_actor.alpha         = 1.0
        })

      animation_make(lambda {
        @scene2_actress.alpha       = 1.0
        }, nil, 0.5, 1.0)
      
      @line_4.play

    when @line_4

      @line_4_1.play

      self.performSelector('romantic_cliche:', withObject:nil, afterDelay:1.5)

    when @line_4_1

      animation_make(lambda {
        @left_quote.alpha           = 0.0
        @right_quote.alpha          = 0.0
        @scene2_actor_line.alpha    = 0.0
        @scene2_actress_line.alpha  = 0.0

        @scene2_actor.frame = [[246, 392], [53, 137]]
        @scene2_actress.frame = [[723, 385], [53, 137]]

        @question_mark.alpha = 1.0
        @question_mark.frame = [[367, 17], [290, 541]]
        }, nil, 0.3)

      @line_5.play

    when @line_5

      puts 'Stage 2 finished!'
      App.delegate.open_stage(3)

    end
  end

  def shake_heart(sender)
    @heart.shake offset: 0.1, repeat: 2, duration: 0.5, keypath: 'transform.rotation' unless @heart.nil?
  end

  def romantic_cliche(sender)
    @scene2_actor_line.alpha    = 1.0
    @left_quote.alpha           = 1.0
    @scene2_actress_line.alpha  = 1.0
    @right_quote.alpha          = 1.0
    @scene2_actor_line.text     = 'It\'s you!'
    @scene2_actor.image         = UIImage.imageNamed('stage2_scene2_1_actor')
    @scene2_actress_line.text   = 'Aha!'
    @scene2_actress.image       = UIImage.imageNamed('stage2_scene2_1_actress')
  end

end