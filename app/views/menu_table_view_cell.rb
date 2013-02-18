class MenuTableViewCell < UITableViewCell
  MENU_CELL_REUSE_ID = 'MenuTableViewCell'

  def self.forMenuItem(title, iconName, selected, tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(MENU_CELL_REUSE_ID) ||
      self.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: MENU_CELL_REUSE_ID)

    cell.labelText = title
    cell.iconName = selected ? "#{iconName}Enabled" : "#{iconName}Disabled"
    cell.selected = selected

    cell
  end

  def initWithStyle(style, reuseIdentifier: identifier)
    super

    self.selectionStyle = UITableViewCellSelectionStyleNone
    self.contentView.addSubview(drawMenuLabel)
    self.contentView.addSubview(drawMenuIcon)
    self.contentView.addSubview(drawSeparatorImage)

    self
  end

  def labelText=(text)
    menuLabel.text = text
  end

  def iconName=(name)
    menuIcon.image = UIImage.imageNamed(name)
  end

  def selected=(flag)
    if flag
      menuLabel.backgroundColor = UIColor.colorWithPatternImage(enabledBackground)
      menuLabel.textColor = UIColor.whiteColor
      menuIcon.backgroundColor = UIColor.colorWithPatternImage(enabledBackground)
    else
      menuLabel.backgroundColor = UIColor.colorWithPatternImage(disabledBackground)
      menuLabel.textColor = UIColor.lightGrayColor
      menuIcon.backgroundColor = UIColor.colorWithPatternImage(disabledBackground)
    end
  end

  def menuLabel
    self.contentView.subviews[0]
  end

  def menuIcon
    self.contentView.subviews[1]
  end

  private

  def drawMenuLabel
    UILabel.alloc.init.tap do |label|
      label.setFrame([[0, 60], [80, 30]])
      label.textAlignment = UITextAlignmentCenter
    end
  end

  def drawMenuIcon
    UIImageView.alloc.init.tap do |icon|
      icon.setFrame([[0, 0], [80, 60]])
    end
  end

  def drawSeparatorImage
    UIImageView.alloc.initWithFrame([[0, 60 + 30 - 1], [80, 5]]).tap do |s|
      s.image = UIImage.imageNamed('separatorLine')
    end
  end

  def enabledBackground
    @enabledBackground ||= UIImage.imageNamed('bgGreyTextureEnabled')
  end

  def disabledBackground
    @disabledBackground ||= UIImage.imageNamed('bgGreyTexture')
  end
end
