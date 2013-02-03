class MapViewController < CyrusSnapsViewController
  def viewDidLoad
    super
    self.view.addSubview(mapView)
  end

  private

  def mapView
    @mapView ||= MKMapView.alloc.initWithFrame(self.view.bounds).tap do |map|
      map.mapType = MKMapTypeStandard
      map.showsUserLocation = true
    end
  end
end
