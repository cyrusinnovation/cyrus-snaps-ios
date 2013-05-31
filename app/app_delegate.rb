class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    return true if RUBYMOTION_ENV == 'test'

    base_url = NSBundle.mainBundle.objectForInfoDictionaryKey('BASE_URL')
    APIClient.register(:photo_api, PhotoClient.new(base_url))

    @window = UIWindow.alloc.init.tap do |w|
      w.frame = UIScreen.mainScreen.bounds
      w.makeKeyAndVisible
      w.rootViewController = MenuViewController.alloc.init

      # show splash screen
      w.rootViewController.view.addSubview(splash_image_view)
      w.rootViewController.view.bringSubviewToFront(splash_image_view)
    end

    fade_out_splash_screen

    true
  end

  private

  def splash_image_view
    @splash_image_view ||=
      UIImageView.alloc.initWithImage(UIImage.imageNamed("Default.png"))
  end

  def fade_out_splash_screen
    fade_out_timer = 5.0
    UIView.transitionWithView(
      @window,
      duration: fade_out_timer,
      options: UIViewAnimationOptionTransitionNone,
      animations: lambda { splash_image_view.alpha = 0 },
      completion: lambda do |finished|
        splash_image_view.removeFromSuperview
        splash_image_view = nil
        UIApplication.sharedApplication.setStatusBarHidden(false, animated: false)
      end
    )
  end
end
