class MapViewController < CyrusSnapsViewController
  def viewDidLoad
    super
    annotateMapView
    self.view.addSubview(mapView)
  end

  private

  def mapView
    @mapView ||= MKMapView.alloc.initWithFrame(self.view.bounds).tap do |map|
      map.mapType = MKMapTypeStandard
      map.showsUserLocation = true
      map.userTrackingMode = MKUserTrackingModeFollow
    end
  end

  def annotateMapView
    Photo.find_all do |photo|
      mapView.addAnnotation(PhotoAnnotation.alloc.initWithPhoto(photo))
    end
  end
end
