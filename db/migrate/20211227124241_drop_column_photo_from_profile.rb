class DropColumnPhotoFromProfile < ActiveRecord::Migration[6.1]
  def change
    remove_column :profiles, :photo
  end
end
