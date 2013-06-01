class PhotoClient
  attr_reader :client

  def self.instance
    @client ||= self.new
  end

  def initialize(base_uri)
    @client = AFMotion::Client.build_shared(base_uri) do
      header "Accept", "application/json"
      operation :json
    end
  end

  def get_photos(&block)
    client.get('/photos') do |response|
      if response.success?
        block.call(response.object)
      else
        p "ERROR: #{response.error.localizedDescription}"
        block.call(NullObject.new)
      end
    end
  end

  def post_photo(title, latitude, longitude, image, &block)
    payload = { :photo => {
      :title => title, :latitude => latitude, :longitude => longitude } }

    imageData = UIImage.UIImageJPEGRepresentation(image, 1)

    client.multipart.post('/photos', payload) do |result, form_data|
      if form_data
        form_data.appendPartWithFileData(
          imageData,
          name: "photo[image]",
          fileName:"#{title_to_filename(title)}.jpg",
          mimeType: "image/jpeg"
        )
      else
        block.call(result)
      end
    end
  end

  private

  def title_to_filename(title)
    title.gsub(/[^\w\s_-]+/, '') # keep only basic letters and digits
         .gsub(/(^|\b\s)\s+($|\s?\b)/, '\\1\\2') # remove extra whitespace
         .gsub(/\s+/, '-') # replace remaining spaces with dashes
         .downcase
  end
end
