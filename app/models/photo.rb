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
    APIClient.instance.multipart.post('/photos', payload) do |result, form_data|
      if form_data
        form_data.appendPartWithFileData(
          imageData,
          name: "photo[image]",
          fileName:"#{filename}.jpg",
          mimeType: "image/jpeg"
        )
      else
        block.call(result)
      end
    end
  end

  def self.find_all(&block)
    APIClient.instance.get('/photos') do |response|
      if response.success?
        response.object.each do |json|
          block.call(self.alloc.initWithJSON(json))
        end
      else
        p "ERROR: #{response.error.localizedDescription}"
        block.call(NullObject.new)
      end
    end
  end

  private

  def imageData
    UIImage.UIImageJPEGRepresentation(image, 1)
  end

  def payload
    { :photo => {
      :title => title, :latitude => latitude, :longitude => longitude } }
  end

  def filename
    title.gsub(/[^\w\s_-]+/, '') # keep only basic letters and digits
         .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2') # remove extra whitespace
         .gsub(/\s+/, '-') # replace remaining spaces with dashes
         .downcase
  end
end
