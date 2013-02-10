class PhotoDetailViewController < UIViewController
  attr_accessor :photo_url

  def initWithURL(url)
    self.init.tap do |vc|
      vc.photo_url = url
    end
  end

  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.blackColor
    self.view.addSubview(imageView)
  end

  private

  def image
    imageData = NSData.alloc.initWithContentsOfURL(photo_url)
    @image ||= UIImage.imageWithData(imageData)
  end

  def imageView
    @imageView ||= UIImageView.alloc.initWithImage(image).tap do |view|
      view.frame = self.view.bounds
      view.contentMode = UIViewContentModeCenter
    end
  end
end
