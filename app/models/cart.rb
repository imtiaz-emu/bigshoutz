# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items, allow_destroy: true,
                                reject_if: proc { |attrs| attrs['quantity'].blank? }

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  # object can be either Listing or Addon
  def add_item(object, quantity = nil, addon_for_listing_id = nil)
    current_item = line_items.find_by(line_item_able_id: object.id, line_item_able_type: object.class.name)

    if current_item
      current_item.quantity += (quantity || 1)
    else
      current_item = line_items.build(
        line_item_able_id: object.id,
        line_item_able_type: object.class.name,
        quantity: quantity || 1,
        addon_for_listing_id: addon_for_listing_id
      )
    end

    current_item
  end
end
