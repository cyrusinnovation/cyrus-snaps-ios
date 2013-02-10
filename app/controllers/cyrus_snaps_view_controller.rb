class CyrusSnapsViewController < UIViewController
  def viewDidLoad
    super

    self.navigationItem.title = 'Cyrus Snaps'
    self.navigationItem.leftBarButtonItem =
      UIBarButtonItem.alloc.initWithCustomView(menuButton)
  end

  def toggleMenu(sender)
    frameView = self.navigationController.view.frame
    frameView.origin.x = 0 == frameView.origin.x ? 80 : 0
    UIView.animateWithDuration(0.1, animations: lambda do
      self.navigationController.view.frame = frameView
    end)
  end

  def menuButton
    @menuButton ||= UIButton.buttonWithType(UIButtonTypeCustom).tap do |b|
      b.setFrame([[0, 0], [40, 35]])
      b.setImage(menuEnabledImage, forState: UIControlStateSelected)
      b.setImage(menuEnabledImage, forState: UIControlStateHighlighted)
      b.setImage(menuDisabledImage, forState: UIControlStateNormal)
      b.addTarget(
        self,
        action: :'toggleMenu:',
        forControlEvents: UIControlEventTouchUpInside
      )
    end
  end

  private

  def menuEnabledImage
    @icnMenuEnabledImage ||= UIImage.imageNamed('icnMenuEnabled')
  end

  def menuDisabledImage
    @icnMenuDisabledImage ||= UIImage.imageNamed('icnMenuDisabled')
  end
end
