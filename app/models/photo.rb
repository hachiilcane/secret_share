class Photo < ActiveRecord::Base
  before_save :set_original_time

  def create_medium_thumbnail
    img = make_thumbnail(self.full_name, 240.0)
    self.thumbnail_medium = img.to_blob
  end

  def create_small_thumbnail
    img = make_thumbnail(self.full_name, 80.0)
    self.thumbnail_small = img.to_blob
  end

  private

  def set_original_time
    unless self.date_time_original
      self.date_time_original = get_original_time_by_exif(self.full_name)
    end
  end

  def get_original_time_by_exif(full_name)
    img = Magick::ImageList.new(full_name)
    exif_time_str = img.get_exif_by_entry('DateTimeOriginal')[0][1]
    exif_time_str.sub!(/^(\d\d\d\d).(\d\d).(\d\d)/, '\1-\2-\3')
    original_time = Time.parse(exif_time_str)
  end

  def make_thumbnail(full_name, limit_width)
    img = Magick::ImageList.new(full_name)
    scale = img.columns > limit_width ? limit_width / img.columns : 1.0
    out_img = img.auto_orient.thumbnail(scale)
  end
end
