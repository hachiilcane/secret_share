class CreateDirectories < ActiveRecord::Migration
  def change
    create_table :directories do |t|
      t.string :path
      t.timestamp :modified_at

      t.timestamps
    end
  end
end
