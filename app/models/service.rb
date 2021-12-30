class Service < ApplicationRecord
  validates_presence_of :title, :description

  has_one_attached :image, dependent: :destroy do |attachable|
    attachable.variant :main, resize: '250x250'
  end
end
