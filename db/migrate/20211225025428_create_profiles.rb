class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.integer   :user_id
      t.string    :first_name
      t.string    :last_name
      t.date      :date_of_birth
      t.integer   :gender
      t.string    :photo
      t.string    :mobile_no
      t.text      :about_me

      t.timestamps
    end
  end
end
