class PhotoAnnotationView < MKPinAnnotationView
  ANNOTATION_VIEW_REUSE_ID = "AnnotationView"

  def self.forAnnotation(mapView, annotation)
    mapView.dequeueReusableAnnotationViewWithIdentifier(ANNOTATION_VIEW_REUSE_ID) ||
      self.alloc.initWithAnnotation(annotation, reuseIdentifier: ANNOTATION_VIEW_REUSE_ID)
  end

  def initWithAnnotation(annotation, reuseIdentifier: identifier)
    super

    self.canShowCallout = true
    self.rightCalloutAccessoryView = detailsButton
    self
  end

  def detailsButton
    @detailsButton ||= UIButton.buttonWithType(UIButtonTypeDetailDisclosure)
  end
end
