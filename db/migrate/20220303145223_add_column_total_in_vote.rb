class AddColumnTotalInVote < ActiveRecord::Migration[6.1]
  def change
    add_column :votes, :total, :integer, default: 1
  end
end
