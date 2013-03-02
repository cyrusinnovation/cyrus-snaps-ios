class MenuTableViewCell < UITableViewCell
  CELL_HEIGHT = 60
  CELL_REUSE_ID = 'MenuTableViewCell'

  def self.forMenuItem(title, iconName, tableView)
    cell = tableView.dequeueReusableCellWithIdentifier(CELL_REUSE_ID) ||
      self.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: CELL_REUSE_ID)

    cell.textLabel.text = title
    cell.imageView.image = UIImage.imageNamed("#{iconName}Disabled")
    cell.imageView.highlightedImage = UIImage.imageNamed("#{iconName}Enabled")
    cell.indentationLevel = 1

    cell
  end

  def initWithStyle(style, reuseIdentifier: identifier)
    super

    self.selectionStyle = UITableViewCellSelectionStyleGray
    self.contentView.addSubview(separator)
    self
  end

  private

  def separator
    @separator ||= UIImageView.alloc.init.tap do |imageView|
      imageView.image = UIImage.imageNamed('separatorLine')
      imageView.frame = [[0, CELL_HEIGHT], [self.frame.size.width, imageView.image.size.height]]
    end
  end
end
