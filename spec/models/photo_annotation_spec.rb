describe "photo annotation" do
  before do
    fake_photo = Object.new.tap do |p|
      p.stub!(:latitude, :return => 1)
      p.stub!(:longitude, :return => 2)
      p.stub!(:title, :return => 'My Title')
      p.stub!(:url, :return => '/some/url')
    end

    @annotation = PhotoAnnotation.alloc.initWithPhoto(fake_photo)
  end

  after do
    Stump::Mocks.clear!
  end

  it "has coordinates" do
    @annotation.coordinate.latitude.should == 1
    @annotation.coordinate.longitude.should == 2
  end

  it "has a title" do
    @annotation.title.should == 'My Title'
  end

  it "has a url" do
    api = Object.tap do |obj|
      obj.stub!(:base_uri, :return => 'http://localhost:9292')
    end
    APIClient.register(:photo_api, api)
    @annotation.url.absoluteString.should == 'http://localhost:9292/some/url'
  end

  describe "with photo that does not have a title" do
    it "has a default title" do
      fake_photo = Object.new.tap do |p|
        p.stub!(:title, :return => nil)
      end

      annotation = PhotoAnnotation.alloc.initWithPhoto(fake_photo)
      annotation.title.should == 'Untitled Photo'
    end
  end
end
