BASE_URI = "http://localhost:9292"

class APIClient
  attr_reader :client

  def self.instance
    @@client ||= AFMotion::Client.build_shared(BASE_URI) do
      header "Accept", "application/json"
      operation :json
    end
  end

  def initialize(base_uri=BASE_URI)
    @client ||= AFMotion::Client.build_shared(base_uri) do
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
end
