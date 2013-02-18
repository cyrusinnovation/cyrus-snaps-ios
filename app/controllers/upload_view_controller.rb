class UploadViewController < CyrusSnapsViewController
  def viewDidLoad
    super
    self.navigationItem.title = 'Upload'
    self.view.backgroundColor = UIColor.redColor
    self.view.addSubview(titleTextField)
    self.view.addSubview(chooseButton)
    self.view.addSubview(uploadButton)
    self.view.addSubview(imageView)
  end

  def choosePicture(sender)
    self.presentViewController(imagePicker, animated: true, completion: nil)
  end

  def uploadPhoto(sender)
    p "TODO: Handle photo upload"
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo: info)
    imageView.image = info.objectForKey(UIImagePickerControllerOriginalImage)
    self.dismissViewControllerAnimated(true, completion: nil)
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
    false
  end

  private

  def titleTextField
    @titleTextField ||= UITextField.alloc.init.tap do |field|
      field.autocapitalizationType = UITextAutocapitalizationTypeWords
      field.borderStyle = UITextBorderStyleRoundedRect
      field.delegate = self
      field.enablesReturnKeyAutomatically = true
      field.frame = [[10, 10], [self.view.frame.size.width - 20, 25]]
      field.placeholder = "Title"
      field.returnKeyType = UIReturnKeyDone
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

  def uploadButton
    @uploadButton ||= UIButton.buttonWithType(UIButtonTypeRoundedRect).tap do |b|
      b.setTitle("Upload", forState: UIControlStateNormal)
      b.sizeToFit
      b.frame = CGRect.new([200, 365], b.frame.size)
      b.addTarget(self, action: :'uploadPhoto:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def imagePicker
    @imagePicker ||= UIImagePickerController.alloc.init.tap do |picker|
      picker.setSourceType(UIImagePickerControllerSourceTypePhotoLibrary)
      picker.delegate = self
    end
  end
end
