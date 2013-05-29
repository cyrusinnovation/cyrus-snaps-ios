describe "photo detail view controller" do
  PORTRAIT_IMAGE  = File.expand_path("../resources/portrait.png", __FILE__)
  LANDSCAPE_IMAGE = File.expand_path("../resources/landscape.png", __FILE__)

  describe "general properties" do
    before do
      url = NSURL.URLWithString("file://#{PORTRAIT_IMAGE}")
      self.controller = PhotoDetailViewController.alloc.initWithURL(url)
    end

    tests PhotoDetailViewController

    it "sets the title" do
      controller.navigationItem.title.should == 'Photo'
    end

    it "has an image view for the photo" do
      view("Photo").should.not == nil
    end
  end

  describe "when initialized with portrait photo" do
    before do
      url = NSURL.URLWithString("file://#{PORTRAIT_IMAGE}")
      self.controller = PhotoDetailViewController.alloc.initWithURL(url)
    end

    tests PhotoDetailViewController

    it "sets the scale aspect to 'fill' if width is less than height" do
      view("Photo").contentMode.should == UIViewContentModeScaleAspectFill
    end
  end

  describe "when initialized with landscape photo" do
    before do
      url = NSURL.URLWithString("file://#{LANDSCAPE_IMAGE}")
      self.controller = PhotoDetailViewController.alloc.initWithURL(url)
    end

    tests PhotoDetailViewController

    it "sets the scale aspect to 'fit' if width is more than height" do
      view("Photo").contentMode.should == UIViewContentModeScaleAspectFit
    end
  end
end
