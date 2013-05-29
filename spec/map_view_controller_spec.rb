describe "map view controller" do
  tests MapViewController

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

    photo = Photo.alloc.initWithJSON(json)
    Photo.mock!(:find_all, :yield => photo)

    @view = view("Map View")
  end

  it "sets the title" do
    controller.navigationItem.title.should == 'Map'
  end

  it "has a map view" do
    @view.mapType.should == MKMapTypeStandard
    @view.showsUserLocation.should == true
    @view.userTrackingMode.should == MKUserTrackingModeFollow
  end

  it "adds photo annotations to map view" do
    @view.annotations.size.should == 1
    @view.annotations[0].title.should == 'Statue of Liberty'
  end
end
