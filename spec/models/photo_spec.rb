describe "photo" do
  before do
    @json = {
      "uuid"         => "9688bed0-6be5-0130-890d-18fe94490886",
      "content_type" => "image/jpeg",
      "file_size"    => 116011,
      "filename"     => "9688bed0-6be5-0130-890d-18fe94490886-statue-of-liberty.jpg",
      "latitude"     => 40.689199,
      "longitude"    => -74.044517,
      "created_at"   => "2013-03-10T15:21:09-04:00",
      "updated_at"   => "2013-03-10T15:21:09-04:00",
      "url"          => "/tmp/uploads/9688bed0-6be5-0130-890d-18fe94490886-statue-of-liberty.jpg",
      "title"        => "Statue of Liberty"
    }

    @photo = Photo.alloc.initWithJSON(@json)
    @photo.image = stub(:image)
  end

  after do
    Stump::Mocks.clear!
  end

  it "can be initialized with a JSON object" do
    @photo.latitude.should == 40.6891937255859
    @photo.longitude.should == -74.0444946289062
    @photo.title.should == 'Statue of Liberty'
    @photo.url.should == '/tmp/uploads/9688bed0-6be5-0130-890d-18fe94490886-statue-of-liberty.jpg'
  end

  it "can retrieve all photos from API" do
    api = mock(:get_photos, :yield => [@json])
    APIClient.register(:photo_api, api)

    result = [].tap do |r|
      Photo.find_all do |photo|
        r << photo
      end
    end

    result.size.should == 1
    result[0].should == Photo.alloc.initWithJSON(@json)
  end

  describe "equality" do
    it "is equal to another photo if they have the same uuid" do
      same_photo = Photo.alloc.initWithJSON(@json)
      @photo.should == same_photo
    end

    it "is not equal to another photo if uuid's are different" do
      json = @json
      json["uuid"] = 'not same uuid'
      different_photo = Photo.alloc.initWithJSON(json)
      @photo.should.not == different_photo
    end

    it "is not equal to another photo if one uuid is nil" do
      json = @json
      json["uuid"] = nil
      different_photo = Photo.alloc.initWithJSON(json)
      @photo.should.not == different_photo
    end

    it "is not equal to another photo if both uuid's are nil" do
      json = @json
      json["uuid"] = nil
      different_photo = Photo.alloc.initWithJSON(json)
      @photo.uuid = nil
      @photo.should.not == different_photo
    end
  end

  describe "validations" do
    it "is valid with valid attributes" do
      @photo.valid?.should == true
    end

    it "is invalid if title is nil" do
      @photo.title = nil
      @photo.valid?.should == false
    end

    it "is invalid if title is blank" do
      @photo.title = ''
      @photo.valid?.should == false
    end

    it "is invalid if image is nil" do
      @photo.image = nil
      @photo.valid?.should == false
    end
  end

  describe "uploads" do
    it "uploads a photo if it is valid" do
      response = stub(:success?, :return => true)
      api = mock(:post_photo, :yield => response)
      APIClient.register(:photo_api, api)

      result = nil
      photo = Photo.alloc.initWithJSON(@json)
      photo.image = stub(:image)
      photo.stub!(:scaled_image)
      photo.upload { |resp| result = resp }
      result.success?.should == true
    end

    it "does not upload a photo if it is invalid" do
      result = nil
      invalid_photo = Photo.alloc.initWithJSON(@json)
      invalid_photo.upload { |resp| result = resp }
      result.should == nil
    end
  end

  describe "image scaling" do
    before do
      @photo = Photo.alloc.initWithJSON(@json)
    end

    it "scales portrait images" do
      filename  = File.expand_path("../../resources/portrait.png", __FILE__)
      @photo.image = UIImage.alloc.initWithContentsOfFile(filename)
      @photo.scaled_image.size.width.should == 240.0
      @photo.scaled_image.size.height.should == 320.0
    end

    it "scales landscape images" do
      filename = File.expand_path("../../resources/landscape.png", __FILE__)
      @photo.image = UIImage.alloc.initWithContentsOfFile(filename)
      @photo.scaled_image.size.width.should == 320.0
      @photo.scaled_image.size.height.should == 240.0
    end
  end
end
