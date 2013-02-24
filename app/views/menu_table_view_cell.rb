class MenuTableViewCell < UITableViewCell
  MENU_CELL_REUSE_ID = 'MenuTableViewCell'

  def self.forMenuItem(title, iconName, tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(MENU_CELL_REUSE_ID) ||
      self.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: MENU_CELL_REUSE_ID)

    cell.textLabel.text = title
    cell.imageView.image = UIImage.imageNamed("#{iconName}Enabled")

    cell
  end

  def initWithStyle(style, reuseIdentifier: identifier)
    super

    self.selectionStyle = UITableViewCellSelectionStyleNone
    self.textLabel.textColor = UIColor.whiteColor

    self.contentView.addSubview(separator)
    self
  end

  private

  def separator
    @separator ||= UIImageView.alloc.init.tap do |s|
      s.frame = [[0, self.frame.size.height], [self.frame.size.width, 5]]
      s.image = UIImage.imageNamed('separatorLine')
    end
  end
end
