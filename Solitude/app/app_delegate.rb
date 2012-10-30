class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible
    map_urls
    
    AVAudioSession.sharedInstance.setCategory(AVAudioSessionCategoryPlayback, error:nil)

    line_url        = NSURL.fileURLWithPath(NSBundle.mainBundle.pathForResource('bgm', ofType:'m4a'))
    @bgm            = AVAudioPlayer.alloc.initWithContentsOfURL(line_url, error:nil)
    @bgm.delegate   = self

    @router.open('Stage0', true)
    true
  end


  def map_urls
    @router = Routable::Router.router
    @router.navigation_controller = UINavigationController.new
      @router.map('Stage0', Stage0)
      @router.map('Stage1', Stage1)
      @router.map('Stage2', Stage2)
      @router.map('Stage3', Stage3)
      @router.map('Stage4', Stage4)
      @router.map('Stage5', Stage5)
      @router.map('Stage7', Stage7)
      @router.map('Stage8', Stage8)
      @router.map('Stage9', Stage9)
    @window.rootViewController = @router.navigation_controller
  end

  def pop
    @router.navigation_controller.pop
  end

  def open_stage(num)
    @router.open("Stage#{num}", true)
  end

  def bgm
    @bgm
  end

end
