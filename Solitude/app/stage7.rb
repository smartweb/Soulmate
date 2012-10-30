class Stage7 < StageVC

  AC = {
      :view => {
          :frame => CGRectMake(0, 0, 1024, 576)
      },
      :actor => {
          :start => CGRectMake(123, 198, 89, 190)
      },
      :question => {
          :start => CGRectMake(321, 137, 162, 301)
      },
      :dozen => {
          :start => CGRectMake(559, 179, 276, 218)
      },
      :nerd => {
          :start => CGRectMake(0, 0, 449, 576)
      },
      :cat => {
          :start => CGRectMake(487, 176, 500, 400)
      },
      :cop => {
          :start => CGRectMake(-31, 176, 500, 400)
      },
      :shadow => {
          :start => CGRectMake(989, 131, 1, 314),
          :end => CGRectMake(464, 131, 525, 314)
      },
      :ten_pa => {
          :start => CGRectMake(382, 79, 100, 52)
      },
      :op_one => {
          :start => CGRectMake(199, 156, 583, 94),
          :nums => %w(5 0 , 0 0 0),
          :label => CGRectMake(493, 206, 465, 44)
      },
      :op_two => {
          :start => CGRectMake(199, 275, 583, 94),
          :nums => %w(5 0 0 , 0 0 0 , 0 0 0),
          :label => CGRectMake(711, 326, 247, 44)
      },
      :line => {
          :start => CGRectMake(199, 258, 0, 10),
          :end => CGRectMake(199, 258, 769, 10)
      },
      :ten_k => {
          :start => CGRectMake(151, 78, 1256, 1629),
          :end   => CGRectMake(303, 16, 419, 544),
      }
  }

  def loadView
    super
    self.view = StageView.stage

    @goto = GotoBtn.goto 8
    self.view << @goto

    # scene 1
    @scene1 = UIView.alloc.initWithFrame(AC[:view][:frame])
    @scene1.backgroundColor = UIColor.whiteColor

    @actor = Item.item(AC[:actor][:start], 'stage0_actor')
    @scene1 << @actor

    @question = Item.item(AC[:question][:start], 'stage2_scene2_2_question')
    @question.alpha = 0.0
    @scene1 << @question

    @dozen = Item.item(AC[:dozen][:start], 'stage7_dozen')
    @dozen.alpha = 0.0
    @scene1 << @dozen

    @ten_pa = Item.label(AC[:ten_pa][:start], 40, true)
    @scene1 << @ten_pa

    self.view << @scene1

    # scene 2
    @scene2 = UIView.alloc.initWithFrame(AC[:view][:frame])
    @scene2.backgroundColor = UIColor.whiteColor

    @nerd = Item.item(AC[:nerd][:start], 'stage7_nerd')
    @scene2 << @nerd

    @cat = Item.item(AC[:cat][:start], 'stage7_cat')
    @scene2 << @cat

    # scene 3
    @scene3 = UIView.alloc.initWithFrame(AC[:view][:frame])
    @scene3.backgroundColor = UIColor.whiteColor

    @cop = Item.item(AC[:cop][:start], 'stage7_cop')
    @scene3 << @cop

    # scene 4
    @scene4 = UIView.alloc.initWithFrame(AC[:view][:frame])
    @scene4.backgroundColor = UIColor.whiteColor

    @op1 = Item.label(AC[:op_one][:start], 100, true)
    @op1.textAlignment = UITextAlignmentLeft
    @scene4 << @op1

    @op1_label = Item.label(AC[:op_one][:label], 32, true)
    @op1_label.textAlignment = UITextAlignmentLeft
    @op1_label.alpha = 0.0
    @op1_label.text = 'eye contact with strangers in a lifetime'
    @scene4 << @op1_label

    @op2 = Item.label(AC[:op_two][:start], 100, true)
    @op2.textAlignment = UITextAlignmentLeft
    @scene4 << @op2

    @op2_label = Item.label(AC[:op_two][:label], 32, true)
    @op2_label.textAlignment = UITextAlignmentLeft
    @op2_label.alpha = 0.0
    @op2_label.text = 'potential soul mates'
    @scene4 << @op2_label

    @helper = UIView.alloc.initWithFrame([[0, 575], [1, 1]])
    @helper.backgroundColor = UIColor.whiteColor
    @scene4 << @helper

    @black_line = UIView.alloc.initWithFrame(AC[:line][:start])
    @black_line.backgroundColor = UIColor.blackColor
    @scene4 << @black_line

    @possibility = Item.label([[69, 194], [131, 137]], 100, true)
    @possibility.textAlignment = UITextAlignmentLeft
    @possibility.alpha = 0.0
    @possibility.text = 'P='
    @scene4 << @possibility

    @ten_k = Item.item(AC[:ten_k][:start], 'stage7_10000')
    @ten_k.alpha = 0.0
    self.view << @ten_k
  end

  def viewDidLoad
    super

    @line_20 = make_line(20, self)
    @line_21 = make_line(21, self)
    @line_22 = make_line(22, self)
    @line_22_1 = make_line('22.1', self)
    @line_23 = make_line(23, self)
    @line_24 = make_line(24, self)
    @line_24_1 = make_line('24.1', self)
    @line_25 = make_line(25, self)
    @line_25_1 = make_line('25.1', self)
  end

  def viewDidAppear(animated)
    super
    @line_20.play
  end

  def viewDidDisappear(animated)
    super
    @line_20.stop
    @line_21.stop
    @line_22.stop
    @line_22_1.stop
    @line_23.stop
    @line_24.stop
    @line_24_1.stop
    @line_25.stop
    @line_25_1.stop
  end

  def audioPlayerDidFinishPlaying(player, successfully:finished)
    case player
      when @line_20
        @line_21.play
        animation_make(lambda {@question.alpha = 1.0; @dozen.alpha = 1.0})
      when @line_21
        @line_22.play
        UIView.transitionFromView(@scene1,
                           toView:@scene2,
                         duration:0.5,
                          options:UIViewAnimationOptionTransitionFlipFromLeft,
                       completion:nil)
      when @line_22
        @line_22_1.play
        UIView.transitionFromView(@scene2,
                                  toView:@scene3,
                                  duration:0.5,
                                  options:UIViewAnimationOptionTransitionFlipFromLeft,
                                  completion:lambda {|finished| add_crowd })
      when @line_22_1
        @line_23.play
        UIView.transitionFromView(@scene3,
                                  toView:@scene1,
                                  duration:0.5,
                                  options:UIViewAnimationOptionTransitionFlipFromRight,
                                  completion:lambda {|finished| proceed_scene1 })
      when @line_23
        @line_24.play
        @shadow = UIView.alloc.initWithFrame(AC[:shadow][:start])
        @shadow.backgroundColor = UIColor.whiteColor
        @shadow.alpha = 0.9
        @scene1 << @shadow
        animation_make(lambda {
          @shadow.frame = AC[:shadow][:end]
        },
        lambda { |finished| @ten_pa.text = '10%' }, 0.5)
      when @line_24
        @line_24_1.play
        UIView.transitionFromView(@scene1,
                                  toView:@scene4,
                                  duration:0.5,
                                  options:UIViewAnimationOptionTransitionCurlUp,
                                  completion:lambda {|finished|
                                    animate_number(AC[:op_one][:nums], 0, @op1)
                                    animation_make(lambda {@op1_label.alpha = 1.0}, nil, 0.3, 0.5)
                                  })
      when @line_24_1
        @line_25.play
        animate_number(AC[:op_two][:nums], 0, @op2)
        animation_make(lambda {@op2_label.alpha = 1.0}, nil, 0.1, 1.1)
        animation_make(lambda {@black_line.frame = AC[:line][:end]; @possibility.alpha = 1.0})
      when @line_25
        @line_25_1.play
        animation_make(lambda {
          @scene4.frame = [[0, -576], [1024, 576]]
          @ten_k.alpha = 1.0
          @ten_k.frame = AC[:ten_k][:end]
        }, nil, 0.3, 0.0, UIViewAnimationCurveEaseInOut)
      when @line_25_1
        puts 'Stage 7 finished!'
        animation_make(lambda { @helper.alpha = @helper.alpha == 1.0 ? 0.0 : 1.0 },
                       lambda { |complete| App.delegate.open_stage(8) }, 0.5)
    end
  end

  def proceed_scene1
    animation_make(lambda {
      @question.alpha = 0.0
      @dozen.alpha = 0.0
    },
    lambda { |finished|
      add_eye_contact
    })
  end

  def add_eye_contact(i=0)
    if i < 6
      x = 399 + i%3 * (8 + 190)
      y = 131 + i/3 * (8 + 153)
      crowd = Item.item([[x, y], [190, 153]], 'stage7_dozen')
      crowd.alpha = 0.0
      @scene1 << crowd
      animation_make(lambda { crowd.alpha = 1.0 },
                     lambda { |finished| add_eye_contact(i+1) },
                     0.05)
    end
  end

  def add_crowd(i=0)
    if i < 42
      x = 448 + i%6 * (8 + 86)
      y = 23  + i/6 * (8 + 69)
      crowd = Item.item([[x, y], [86, 69]], 'stage7_dozen_small')
      crowd.alpha = 0.0
      @scene3 << crowd
      animation_make(lambda { crowd.alpha = 1.0 },
                     lambda { |finished| add_crowd(i+1) },
                     0.05)
    end
  end

  def animate_number(op, i=0, item)
    if i < op.length
      num = op[i].to_s
      item.text = item.text.to_s + num
      animation_make(lambda { @helper.alpha = @helper.alpha == 1.0 ? 0.0 : 1.0 },
                     lambda { |finished| animate_number(op, i+1, item) }, 0.1)
    end
  end

end