class Photo
  attr_accessor :latitude, :longitude, :url

  def initWithJSON(json)
    json.each do |k, v|
      method = "#{k}="
      self.send(method, v) if self.respond_to?(method)
    end

    self
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
end
