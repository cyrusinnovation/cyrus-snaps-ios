class PhotoAnnotation
  def initWithPhoto(photo)
    @coordinate = CLLocationCoordinate2DMake(photo.latitude, photo.longitude)

    self
  end

  def coordinate
    @coordinate
  end
end
