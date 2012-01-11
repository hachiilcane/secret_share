class AddThumbnailMediumAndThumbnailSmallToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :thumbnail_medium, :binary
    add_column :photos, :thumbnail_small, :binary
  end
end
