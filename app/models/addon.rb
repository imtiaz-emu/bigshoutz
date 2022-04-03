class Addon < ApplicationRecord
  validates_presence_of :name, :price, :is_active

  has_one_attached :image, dependent: :destroy do |attachable|
    attachable.variant :main, resize: '250x250'
  end
end
