class AddNewColumnsToListing < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :is_free, :boolean, default: false
    add_column :listings, :event_address, :string
    add_column :listings, :video_preview_duration, :integer
  end
end
