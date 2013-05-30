class APIClient
  class << self
    def register(name, api)
      apis[name] = api
    end

    def for(name)
      apis[name]
    end

    def apis
      @apis ||= {}
    end
  end
end
