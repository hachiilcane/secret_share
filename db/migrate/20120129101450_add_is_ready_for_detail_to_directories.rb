class AddIsReadyForDetailToDirectories < ActiveRecord::Migration
  def change
    add_column :directories, :is_ready_for_detail, :boolean
  end
end
