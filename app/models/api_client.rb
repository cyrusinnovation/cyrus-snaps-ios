BASE_URI = "http://localhost:9292"

class APIClient
  def self.instance
    @@client ||= AFMotion::Client.build_shared(BASE_URI) do
      header "Accept", "application/json"
      operation :json
    end
  end
end
