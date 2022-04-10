class CreateAddons < ActiveRecord::Migration[6.1]
  def change
    create_table :addons do |t|
      t.string      :name
      t.text        :description
      t.integer     :stock
      t.float       :price
      t.boolean     :is_active, default: true

      t.timestamps
    end
  end
end
