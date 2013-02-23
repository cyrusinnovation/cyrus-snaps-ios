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
    client = AFMotion::Client.build(BASE_URI)
    client.multipart.post('/photos', { :photo => payload }) do |result, form_data|
      if form_data
        form_data.appendPartWithFileData(imageData, name: "photo[image]", fileName:"avatar.jpg", mimeType: "image/jpeg")
      elsif result.success?
        block.call("SUCCESS!!!")
      else
        block.call("FAILURE!!! #{result.error.localizedDescription}")
      end
    end
  end

  def self.find_all(&block)
    BubbleWrap::HTTP.get(BASE_URI + '/photos') do |response|
      if response.body
        BubbleWrap::JSON.parse(response.body.to_str).each do |json|
          block.call(self.alloc.initWithJSON(json))
        end
      else
        block.call(NullObject.new)
      end
    end
  end

  private

  def imageData
    UIImage.UIImageJPEGRepresentation(image, 1)
  end

  def payload
    {
      "latitude" => latitude,
      "longitude" => longitude
    }
  end
end
