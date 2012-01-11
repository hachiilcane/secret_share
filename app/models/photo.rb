class Photo < ActiveRecord::Base
  before_save :set_original_time

  private

  def set_original_time
    self.date_time_original = get_original_time_by_exif(self.full_name)
  end


  def get_original_time_by_exif(full_name)
    img = Magick::ImageList.new(full_name)
    exif_time_str = img.get_exif_by_entry('DateTimeOriginal')[0][1]
    exif_time_str.sub!(/^(\d\d\d\d).(\d\d).(\d\d)/, '\1-\2-\3')
    original_time = Time.parse(exif_time_str)
  end
end
