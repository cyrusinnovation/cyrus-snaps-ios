class CyrusSnapsViewController < UIViewController
  def viewDidLoad
    super

    self.navigationItem.leftBarButtonItem =
      UIBarButtonItem.alloc.initWithImage(
        UIImage.imageNamed('menu'),
        style: UIBarButtonItemStylePlain,
        target: self,
        action: :'toggleMenu:'
    )
  end

  def toggleMenu(sender)
    frameView = self.navigationController.view.frame
    frameView.origin.x = 0 == frameView.origin.x ? 160 : 0
    UIView.animateWithDuration(0.1, animations: lambda do
      self.navigationController.view.frame = frameView
    end)
  end
end
