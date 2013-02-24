class MenuViewController < UITableViewController
  def viewDidLoad
    super

    @current_section = 0
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    tableView.backgroundColor =
      UIColor.colorWithRed(115/255.0, green: 115/255.0, blue: 35/255.0, alpha: 1.0)

    switchToView(0)
  end

  def switchToView(index)
    navigationController.view.frame = self.view.bounds
    controller = [menuSections[index][:view_controller]]
    navigationController.setViewControllers(controller, animated: true)
    self.view.addSubview(navigationController.view)
  end

  def navigationController
    @navigationController ||= UINavigationController.alloc.init.tap do |nc|
      nc.navigationBar.tintColor =
        UIColor.colorWithRed(190/255.0, green: 202/255.0, blue: 46/255.0, alpha: 1.0)
    end
  end

  def menuSections
    @sections ||= [
      { title: 'Map',
        icon: 'mapMarker',
        view_controller: MapViewController.alloc.init },
      { title: 'Upload',
        icon: 'camera',
        view_controller: UploadViewController.alloc.init }
    ]
  end

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    menuSections.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    title = menuSections[indexPath.row][:title]
    icon  = menuSections[indexPath.row][:icon]

    MenuTableViewCell.forMenuItem(title, icon, tableView)
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    return if @current_section == indexPath.row

    @current_section = indexPath.row
    tableView.reloadData
    switchToView(@current_section)
  end
end
