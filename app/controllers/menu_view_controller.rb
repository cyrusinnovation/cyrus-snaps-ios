class MenuViewController < UITableViewController
  def viewDidLoad
    super

    @current_section = 0
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone
    tableView.backgroundColor = UIColor.grayColor

    switchToView(@current_section)
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
        icon: 'globe',
        view_controller: MapViewController.alloc.init },
      { title: 'Upload',
        icon: 'camera-with-picture',
        view_controller: UploadViewController.alloc.init }
    ]
  end

  def numberOfSectionsInTableView(tableView)
    1
  end

  def tableView(tableView, numberOfRowsInSection: section)
    menuSections.count
  end

  def tableView(tableView, heightForRowAtIndexPath: indexPath)
    MenuTableViewCell::CELL_HEIGHT
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
    tableView.cellForRowAtIndexPath(indexPath).selected = true
    switchToView(@current_section)
  end
end
