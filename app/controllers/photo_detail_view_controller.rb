class PhotoDetailViewController < UIViewController
  attr_accessor :photo_url

  def initWithURL(url)
    self.init.tap do |vc|
      vc.photo_url = url
    end
  end

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.whiteColor
    self.view.addSubview(imageView)
    self.navigationItem.title = 'Photo'
  end

  private

  def image
    imageData = NSData.alloc.initWithContentsOfURL(photo_url)
    @image ||= UIImage.imageWithData(imageData)
  end

  def imageView
    @imageView ||= UIImageView.alloc.initWithImage(image).tap do |view|
      view.accessibilityLabel = 'Photo'
      view.frame = self.view.bounds
      view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)

      view.contentMode = if image.size.width > image.size.height
        UIViewContentModeScaleAspectFit
      else
        UIViewContentModeScaleAspectFill
      end
    end
  end
end
