class CreateListings < ActiveRecord::Migration[6.1]
  def change
    create_table :listings do |t|
      t.integer     :service_id
      t.integer     :owner_id
      t.string      :name, default: '', null: false
      t.text        :description
      t.datetime    :available_on
      t.decimal     :price, precision: 10, scale: 2
      t.datetime    :deleted_at
      t.text        :meta_description
      t.string      :meta_keywords
      t.boolean     :promotionable, default: true
      t.string      :meta_title
      t.datetime    :discontinue_on
      t.string      :talk_type
      t.datetime    :event_time
      t.string      :event_place
      t.datetime    :live_session_time
      t.datetime    :live_session_end_time

      t.timestamps
    end

    add_index :listings, :available_on
    add_index :listings, :deleted_at
    add_index :listings, :discontinue_on
    add_index :listings, :name
    add_index :listings, :service_id
    add_index :listings, :owner_id
  end
end
