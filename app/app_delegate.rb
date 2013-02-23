class AppDelegate
  def application(application, didFinishLaunchingWithOptions: launchOptions)
    @window = UIWindow.alloc.init.tap do |w|
      w.frame = UIScreen.mainScreen.bounds
      w.makeKeyAndVisible
      w.rootViewController = MenuViewController.alloc.init
    end

    true
  end
end
