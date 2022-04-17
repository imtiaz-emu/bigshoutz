# == Schema Information
#
# Table name: services
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Service < ApplicationRecord
  has_many :listings

  validates_presence_of :title, :description

  scope :active, -> { where(active: true) }

  has_one_attached :image, dependent: :destroy do |attachable|
    attachable.variant :main, resize: '250x250'
  end

  DEFAULT_SERVICES = ['Hang Out', 'Live Video', 'Exclusives', 'Shout Out'].freeze
end
