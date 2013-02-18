class UploadViewController < CyrusSnapsViewController
  def viewDidLoad
    super
    self.view.backgroundColor = UIColor.redColor
    self.view.addSubview(titleTextfield)
    self.view.addSubview(chooseButton)
    self.view.addSubview(imageView)
  end

  def choosePicture(sender)
    self.presentViewController(imagePicker, animated: true, completion: nil)
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo: info)
    imageView.image = info.objectForKey(UIImagePickerControllerOriginalImage)
    self.dismissViewControllerAnimated(true, completion: nil)
  end

  private

  def titleTextfield
    @titleTextfield ||= UITextField.alloc.init.tap do |field|
      field.backgroundColor = UIColor.whiteColor
      field.borderStyle = UITextBorderStyleRoundedRect
      field.frame = [[10, 10], [self.view.frame.size.width - 20, 30]]
      field.placeholder = "Title"
    end
  end

  def imageView
    @imageView ||= UIImageView.alloc.init.tap do |view|
      x = self.view.frame.size.width - 20
      y = self.view.frame.size.height - 150
      view.setFrame([[10, 50], [x, y]])
      view.backgroundColor = UIColor.whiteColor
    end
  end

  def chooseButton
    @chooseButton ||= UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle("Choose Photo", forState: UIControlStateNormal)
      b.sizeToFit
      b.frame = CGRect.new([10, 365], b.frame.size)
      b.addTarget(self, action: :'choosePicture:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def imagePicker
    @imagePicker ||= UIImagePickerController.alloc.init.tap do |picker|
      picker.setSourceType(UIImagePickerControllerSourceTypePhotoLibrary)
      picker.delegate = self
    end
  end
end
