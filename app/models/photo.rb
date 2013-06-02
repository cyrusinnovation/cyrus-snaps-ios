class Photo
  SCALE_X = 320.0
  SCALE_Y = 240.0

  attr_accessor :image, :latitude, :longitude, :title, :url, :uuid

  def initWithJSON(json)
    json.each do |k, v|
      method = "#{k}="
      self.send(method, v) if self.respond_to?(method)
    end

    self
  end

  def upload(&block)
    return unless valid?
    APIClient.for(:photo_api).post_photo(title, latitude, longitude, scaled_image) do |result|
      block.call(result)
    end
  end

  def self.find_all(&block)
    APIClient.for(:photo_api).get_photos do |photo|
      photo.each do |json|
        block.call(self.alloc.initWithJSON(json))
      end
    end
  end

  def valid?
    title != nil && title != '' && image != nil
  end

  def ==(other)
    self.uuid != nil && other.uuid != nil && self.uuid == other.uuid
  end

  def scale_size
    if image.size.width > image.size.height
      CGSizeMake(SCALE_X, SCALE_Y)
    else
      CGSizeMake(SCALE_Y, SCALE_X)
    end
  end

  def scaled_image
    UIGraphicsBeginImageContext(scale_size)
    image.drawInRect(CGRectMake(0, 0, scale_size.width, scale_size.height))
    scaled_image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    scaled_image
  end
end
