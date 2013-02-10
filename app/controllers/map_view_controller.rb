class MapViewController < CyrusSnapsViewController
  def viewDidLoad
    super
    annotatePhotoMapView
    self.view.addSubview(photoMapView)
  end

  def mapView(mapView, viewForAnnotation: annotation)
    return nil unless annotation.is_a?(PhotoAnnotation)
    dequeueOrInitAnnotationView(mapView, annotation)
  end

  def showImage(sender)
    url = sender.superview.superview.annotation.url
    controller = PhotoDetailViewController.alloc.initWithURL(url)
    self.navigationController.pushViewController(controller, animated: true)
  end

  private

  ANNOTATION_VIEW_REUSE_ID = "AnnotationView"

  def dequeueOrInitAnnotationView(mapView, annotation)
    mapView.dequeueReusableAnnotationViewWithIdentifier(ANNOTATION_VIEW_REUSE_ID) ||
      MKPinAnnotationView.alloc.initWithAnnotation(
        annotation, reuseIdentifier: ANNOTATION_VIEW_REUSE_ID).tap do |view|

      view.canShowCallout = true
      view.rightCalloutAccessoryView = detailsButton
      end
  end

  def detailsButton
    @detailsButton ||= UIButton.buttonWithType(UIButtonTypeDetailDisclosure).tap do |b|
      b.addTarget(self, action: :'showImage:', forControlEvents: UIControlEventTouchUpInside)
    end
  end

  def photoMapView
    @photoMapView ||= MKMapView.alloc.init.tap do |map|
      map.frame = self.view.bounds
      map.mapType = MKMapTypeStandard
      map.showsUserLocation = true
      map.userTrackingMode = MKUserTrackingModeFollow
      map.delegate = self
    end
  end

  def annotatePhotoMapView
    Photo.find_all do |photo|
      photoMapView.addAnnotation(PhotoAnnotation.alloc.initWithPhoto(photo))
    end
  end
end
