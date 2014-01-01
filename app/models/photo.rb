class Photo < ActiveRecord::Base
  belongs_to :directory
  has_many :pickings
  has_many :baskets, :through => :pickings
  attr_accessible :full_name, :directory_id

  def read_original_time
    self.date_time_original = get_original_time_by_exif(self.full_name)
  end

  def create_medium_thumbnail
    img = make_thumbnail(self.full_name, 240.0)
    self.thumbnail_medium = img.to_blob
  end

  def create_small_thumbnail
    img = make_thumbnail(self.full_name, 80.0)
    self.thumbnail_small = img.to_blob
  end

  # makes all data which has not been set
  def make_additional_data
    if !self.date_time_original || !self.thumbnail_medium || !self.thumbnail_small
      img = Magick::ImageList.new(self.full_name)

      if !self.date_time_original
        self.date_time_original = get_original_time_by_exif(img)
      end

      if !self.thumbnail_medium
        thumbnail = make_thumbnail(img, 240.0)
        self.thumbnail_medium = thumbnail.to_blob
      end

      if !self.thumbnail_small
        thumbnail = make_thumbnail(img, 80.0)
        self.thumbnail_small = thumbnail.to_blob
      end
      save!
    end
  end

  private

  # 'DateTimeOriginal' means the time by which the photograph was taken.
  def get_original_time_by_exif(img)
    exif_time_str = img.get_exif_by_entry('DateTimeOriginal')[0][1]
    exif_time_str.sub!(/^(\d\d\d\d).(\d\d).(\d\d)/, '\1-\2-\3')
    original_time = Time.parse(exif_time_str)
  end

  def make_thumbnail(img, limit_width)
    scale = img.columns > limit_width ? limit_width / img.columns : 1.0
    out_img = img.auto_orient.thumbnail(scale)
  end
end
