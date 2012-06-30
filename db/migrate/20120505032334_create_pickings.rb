class CreatePickings < ActiveRecord::Migration
  def change
    create_table :pickings do |t|
      t.integer :photo_id, :null => false
      t.integer :basket_id, :null => false

      t.timestamps
    end
  end
end
