class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer     :user_id
      t.integer     :listing_id
      t.boolean     :vote_type

      t.timestamps
    end

    add_index :votes, :listing_id
    add_index :votes, :user_id
  end
end
