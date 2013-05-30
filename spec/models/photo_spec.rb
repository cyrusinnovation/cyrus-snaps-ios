describe "photo" do
  before do
    json = {
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

    @photo = Photo.alloc.initWithJSON(json)
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
