class UploadViewController < CyrusSnapsViewController
  def viewDidLoad
    super

    self.navigationItem.title = 'Upload'
    self.navigationItem.rightBarButtonItem = uploadButton

    self.view.backgroundColor = UIColor.colorWithRed(115/255.0, green: 115/255.0, blue: 35/255.0, alpha: 1.0)

    self.view.addSubview(titleTextField)
    self.view.addSubview(imageView)
    self.view.addSubview(activity)

  end

  def choosePicture(sender)
    self.presentViewController(imagePicker, animated: true, completion: nil)
  end

  def uploadPhoto(sender)
    activity.startAnimating

    photo = Photo.alloc.init.tap do |p|
      p.title = titleTextField.text
      p.latitude = location_manager.location.coordinate.latitude
      p.longitude = location_manager.location.coordinate.longitude
      p.image = imageView.image
    end

    photo.upload do |response|
      if response.success?
        titleTextField.text = nil
        imageView.image = nil
        imageView.addSubview(clickHereLabel)
      else
        puts("FAILURE!!! #{response.error.localizedDescription}")
      end

      activity.stopAnimating
    end
  end

  def imagePickerController(picker, didFinishPickingMediaWithInfo: info)
    imageView.image = info.objectForKey(UIImagePickerControllerOriginalImage)
    clickHereLabel.removeFromSuperview
    self.dismissViewControllerAnimated(true, completion: nil)
  end

  def textFieldShouldReturn(textField)
    textField.resignFirstResponder
    false
  end

  private

  def activity
    @activity ||= UIActivityIndicatorView.alloc.init.tap do |view|
      view.frame = [[0, 0], self.view.size]
      view.backgroundColor = UIColor.colorWithWhite(0, alpha: 0.8)
      view.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge
      view.addSubview(UILabel.alloc.init.tap do |label|
        label.font = label.font.fontWithSize(36)
        label.adjustsFontSizeToFitWidth = true
        label.frame = [[0, self.view.frame.size.height / 3], [self.view.frame.size.width, 50]]
        label.textColor = UIColor.whiteColor
        label.backgroundColor = UIColor.clearColor
        label.text = "Uploading"
        label.textAlignment = UITextAlignmentCenter
      end)
    end
  end

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
      y = self.view.frame.size.height - 120
      view.layer.cornerRadius = 8;
      view.layer.shadowOpacity = 0.1
      view.setFrame([[10, 60], [x, y]])
      view.backgroundColor = UIColor.whiteColor
      view.userInteractionEnabled = true
      view.addGestureRecognizer(UITapGestureRecognizer.alloc.initWithTarget(self, action: :'choosePicture:'))
      view.addSubview(clickHereLabel)
    end
  end

  def clickHereLabel
    @clickHereLabel ||= UILabel.alloc.init.tap do |label|
      label.font = label.font.fontWithSize(36)
      label.adjustsFontSizeToFitWidth = true
      label.frame = [[20, 10], [self.view.frame.size.width - 60, 50]]
      label.textColor = UIColor.grayColor
      label.text = "Tap to choose photo"
      label.textAlignment = UITextAlignmentCenter
    end
  end

  def uploadButton
    @uploadButton ||= UIBarButtonItem.alloc.initWithTitle(
      'Upload',
      style: UIBarButtonItemStylePlain,
      target: self,
      action: :'uploadPhoto:'
    )
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
