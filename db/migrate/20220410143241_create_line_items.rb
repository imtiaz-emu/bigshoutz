class CreateLineItems < ActiveRecord::Migration[6.1]
  def change
    create_table :line_items do |t|
      t.integer   :line_item_able_id
      t.string    :line_item_able_type
      t.integer   :cart_id

      t.timestamps
    end

    add_index :line_items, [:line_item_able_type, :line_item_able_id]
  end
end
