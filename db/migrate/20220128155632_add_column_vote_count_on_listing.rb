class AddColumnVoteCountOnListing < ActiveRecord::Migration[6.1]
  def change
    add_column :listings, :vote_count, :integer, default: 0
  end
end
