class AddColumnsToProfileAndListing < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :fb_link, :string
    add_column :profiles, :twitter_link, :string
    add_column :profiles, :insta_link, :string
    add_column :listings, :currency, :string
  end
end
