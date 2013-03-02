class UploadViewController < CyrusSnapsViewController
  def viewDidLoad
    super
    self.navigationItem.title = 'Upload'
    self.view.backgroundColor = UIColor.colorWithRed(115/255.0, green: 115/255.0, blue: 35/255.0, alpha: 1.0)
    self.view.addSubview(titleTextField)
    self.view.addSubview(chooseButton)
    self.view.addSubview(uploadButton)
    self.view.addSubview(imageView)
  end

  def choosePicture(sender)
    self.presentViewController(imagePicker, animated: true, completion: nil)
  end

  def uploadPhoto(sender)
    photo = Photo.alloc.init.tap do |p|
      p.title = titleTextField.text
      p.latitude = location_manager.location.coordinate.latitude
      p.longitude = location_manager.location.coordinate.longitude
      p.image = imageView.image
    end

    photo.upload do |response|
      p response
    end
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
      field.textAlignment = NSTextAlignmentCenter
      field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
      field.delegate = self
      field.enablesReturnKeyAutomatically = true
      field.sizeToFit
      field.frame = [[10, 10], [self.view.frame.size.width - 20, field.frame.size.height + 5]]
      field.placeholder = "Enter a Title for Your Photo"
      field.returnKeyType = UIReturnKeyDone
    end
  end

  def imageView
    @imageView ||= UIImageView.alloc.init.tap do |view|
      x = self.view.frame.size.width - 20
      y = self.view.frame.size.height - 150
      view.layer.cornerRadius = 8;
      view.layer.shadowOpacity = 0.1
      view.setFrame([[10, 50], [x, y]])
      view.backgroundColor = UIColor.whiteColor
    end
  end

  def chooseButton
    @chooseButton ||= UIButton.buttonWithType(UIButtonTypeCustom).tap do |b|
      b.setTitle("Choose Photo", forState: UIControlStateNormal)
      b.setBackgroundColor(UIColor.colorWithRed(190/255.0, green: 202/255.0, blue: 46/255.0, alpha: 1.0))
      b.layer.cornerRadius = 8;
      b.layer.borderWidth = 1;
      b.sizeToFit
      height = b.frame.size.height + 20
      width = b.frame.size.width + 20
      b.frame = CGRect.new([10, 365], [width, height])
      b.addTarget(self, action: :'choosePicture:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def uploadButton
    @uploadButton ||= UIButton.buttonWithType(UIButtonTypeCustom).tap do |b|
      b.setTitle("Upload", forState: UIControlStateNormal)
      b.setBackgroundColor(UIColor.colorWithRed(190/255.0, green: 202/255.0, blue: 46/255.0, alpha: 1.0))
      b.layer.cornerRadius = 8;
      b.layer.borderWidth = 1;
      b.sizeToFit
      height = b.frame.size.height + 20
      width = b.frame.size.width + 20
      b.frame = CGRect.new([200, 365], [width, height])
      b.addTarget(self, action: :'uploadPhoto:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def imagePicker
    @imagePicker ||= UIImagePickerController.alloc.init.tap do |picker|
      picker.setSourceType(UIImagePickerControllerSourceTypePhotoLibrary)
      picker.delegate = self
    end
  end

  def location_manager
    @location_manager ||= CLLocationManager.alloc.init.tap do |lm|
      lm.desiredAccuracy = KCLLocationAccuracyBest
      lm.purpose = "Your current location will be associated with the photo."
      lm.startUpdatingLocation
    end
  end
end
