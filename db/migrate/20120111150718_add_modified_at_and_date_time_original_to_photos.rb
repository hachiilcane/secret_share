class AddModifiedAtAndDateTimeOriginalToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :modified_at, :datetime
    add_column :photos, :date_time_original, :datetime
  end
end
