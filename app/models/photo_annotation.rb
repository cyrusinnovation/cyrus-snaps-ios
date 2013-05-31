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
    photo.title || "Untitled Photo"
  end

  def url
    NSURL.URLWithString(APIClient.for(:photo_api).base_uri + photo.url)
  end
end
