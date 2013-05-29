class MapViewController < CyrusSnapsViewController
  def viewDidLoad
    super
    self.view.addSubview(photoMapView)
    self.navigationItem.title = 'Map'
  end

  def viewDidAppear(animated)
    super
    annotatePhotoMapView
  end

  def mapView(mapView, viewForAnnotation: annotation)
    return nil unless annotation.is_a?(PhotoAnnotation)
    PhotoAnnotationView.forAnnotation(mapView, annotation).tap do |view|
      view.detailsButton.addTarget(
        self,
        action: :'showPhotoDetailView:',
        forControlEvents: UIControlEventTouchUpInside
      )
    end
  end

  def showPhotoDetailView(sender)
    url = sender.superview.superview.annotation.url
    controller = PhotoDetailViewController.alloc.initWithURL(url)
    self.navigationController.pushViewController(controller, animated: true)
  end

  private

  def photoMapView
    @photoMapView ||= MKMapView.alloc.init.tap do |map|
      map.frame = self.view.bounds
      map.mapType = MKMapTypeStandard
      map.showsUserLocation = true
      map.userTrackingMode = MKUserTrackingModeFollow
      map.delegate = self
      map.accessibilityLabel = 'Map View'
    end
  end

  def annotatePhotoMapView
    Photo.find_all do |photo|
      photoMapView.addAnnotation(PhotoAnnotation.alloc.initWithPhoto(photo))
    end
  end
end
