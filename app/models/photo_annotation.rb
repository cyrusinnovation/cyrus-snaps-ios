class PhotoAnnotation
  attr_reader :photo

  def initWithPhoto(photo)
    @photo = photo
    self
  end

  def coordinate
    CLLocationCoordinate2DMake(photo.latitude, photo.longitude)
  end

  def title
    "Untitled Photo"
  end

  def url
    photo.url
  end
end
