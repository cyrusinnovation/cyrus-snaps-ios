class Photo
  attr_accessor :image, :latitude, :longitude, :title, :url

  def initWithJSON(json)
    json.each do |k, v|
      method = "#{k}="
      self.send(method, v) if self.respond_to?(method)
    end

    self
  end

  def upload(&block)
    return unless valid?
    PhotoClient.instance.post_photo(title, latitude, longitude, image) do |result|
      block.call(result)
    end
  end

  def self.find_all(&block)
    PhotoClient.instance.get_photos do |photo|
      photo.each do |json|
        block.call(self.alloc.initWithJSON(json))
      end
    end
  end

  def valid?
    title != nil && title != '' && image != nil
  end
end
