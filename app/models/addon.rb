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
  has_many :line_items, as: :line_item_able

  before_destroy :ensure_not_referenced_by_any_line_item

  validates_presence_of :name, :price, :is_active

  has_one_attached :image, dependent: :destroy do |attachable|
    attachable.variant :main, resize: '250x250'
  end

  DEFAULT_ADDONS = %w[Upvote Downvote].freeze

  private

  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
