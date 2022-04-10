# == Schema Information
#
# Table name: addons
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  stock       :integer
#  price       :float
#  is_active   :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  currency    :string           default("MYR")
#
class Addon < ApplicationRecord
  validates_presence_of :name, :price, :is_active

  has_one_attached :image, dependent: :destroy do |attachable|
    attachable.variant :main, resize: '250x250'
  end
end
