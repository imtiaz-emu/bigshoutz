class AddListingIdInLineItemTable < ActiveRecord::Migration[6.1]
  def change
    add_column :line_items, :addon_for_listing_id, :integer
  end
end
