class Stage1 < StageVC

  AC = {
    :no => {
      :start => CGRectMake(-125, -172, 1299, 919),
      :end   => CGRectMake(271, 66, 500, 354)
    },
    :heart => {
      :start => CGRectMake(491, 166, 76, 76)
    }
  }

  def loadView
    super
    self.view             = StageView.stage

    @goto = GotoBtn.goto 2
    self.view << @goto

    4.times do |index|
      scene1_n       = Item.item([[214, 76], [500, 500]], "stage1_scene1_#{index}")
      scene1_n.alpha = 0.0 unless index == 0
      scene1_n.tag   = index + 100
      self.view << scene1_n
    end

    @heart_offset         = 5.0
    @heart                = Item.item(AC[:heart][:start], 'heart_middle')
    @heart.alpha          = 0.0
    self.view << @heart

    @scene2_actor         = Item.item([[225, 333], [79, 184]], 'stage1_scene2_actor')
    @scene2_actor.alpha   = 0.0
    self.view << @scene2_actor

    @scene2_no            = Item.item(AC[:no][:start], 'stage1_scene2_no')
    @scene2_no.alpha      = 0.0
    self.view << @scene2_no
  end

  def viewDidLoad
    super
    view.sendSubviewToBack(@scene2_no)

    @line_1 = make_line(1, self)
    @line_2 = make_line(2, self)
  end

  def viewWillAppear(animated)
    super
    App.delegate.bgm.play
  end

  def viewDidAppear(animated)
    super
    @line_1.play

    animate_scene1
  end

  def viewDidDisappear(animated)
    super
    @line_1.stop
    @line_2.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    case player
    when @line_1
      animation_make(lambda {
        @scene1_last.alpha    = 0.0
        @scene1_last.removeFromSuperview
        @heart.removeFromSuperview
        @scene2_actor.alpha   = 1.0
        @scene2_no.alpha      = 1.0
        @scene2_no.frame      = AC[:no][:end]
        })
      
      @line_2.play
    when @line_2
      puts 'Stage 1 finished!'
      App.delegate.open_stage(2)
    end
  end

  def animate_scene1(current=0)
    animation_make(
      lambda { view.viewWithTag(100 + current + 1).alpha = 1.0 },
      lambda { |finished|
        view.viewWithTag(100 + current).removeFromSuperview
        if current < 2
          animate_scene1(current + 1)
        else
          @scene1_last = view.viewWithTag(100 + current + 1)
          animate_heart(@heart_offset)
        end
      }
    )
  end

  def animate_heart(offset)
    animation_make(
      lambda {
        @heart.alpha  = 1.0 unless @heart.alpha == 1.0
        @heart.frame  = CGRectMake(AC[:heart][:start].origin.x,
                                   AC[:heart][:start].origin.y + offset,
                                   AC[:heart][:start].size.width,
                                   AC[:heart][:start].size.height)
        @heart_offset = -@heart_offset
      },
      lambda { |finished| animate_heart(@heart_offset) },
      0.5, 0.0, UIViewAnimationOptionCurveEaseInOut
    )
  end

end