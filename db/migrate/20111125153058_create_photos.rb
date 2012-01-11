class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :full_name
      t.integer :directory_id

      t.timestamps
    end
  end
end
