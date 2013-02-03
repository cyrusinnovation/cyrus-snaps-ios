class MenuViewController < UITableViewController
  MENU_ICON_HEIGHT = 60
  MENU_HEIGHT = MENU_ICON_HEIGHT + 30 + 5 - 2
  MENU_WIDTH = 80

  def viewDidLoad
    super

    @current_section = 0
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    tableView.backgroundColor = UIColor.clearColor
    tableView.backgroundView = UIImageView.alloc.initWithImage(UIImage.imageNamed('bgGreyTexture'))

    switchToView(0)
  end

  def switchToView(index)
    navigationController.view.frame = self.view.bounds
    navigationController.setViewControllers([menuSections[index][:view_controller]], animated: true)
    self.view.addSubview(navigationController.view)
  end

  def navigationController
    @navigationController ||= UINavigationController.alloc.init
  end

  def menuSections
    @sections ||= [
      { :title => 'Map',    :icon => 'frame',  :view_controller => MapViewController.alloc.init },
      { :title => 'Album',  :icon => 'album',  :view_controller => AlbumViewController.alloc.init },
      { :title => 'Camera', :icon => 'camera', :view_controller => CameraViewController.alloc.init }
    ]
  end

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    menuSections.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    MENU_HEIGHT
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    title    = menuSections[indexPath.row][:title]
    icon     = menuSections[indexPath.row][:icon]
    selected = @current_section == indexPath.row

    MenuTableViewCell.forMenuItem(title, icon, selected, tableView)
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    return if @current_section == indexPath.row

    @current_section = indexPath.row
    tableView.reloadData
    switchToView(@current_section)
  end
end
