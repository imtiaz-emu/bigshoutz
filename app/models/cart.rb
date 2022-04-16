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

  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end

  # object can be either Listing or Addon
  def add_item(object)
    current_item = line_items.find_by(line_item_able_id: object.id, line_item_able_type: object.class.name)

    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(line_item_able_id: object.id, line_item_able_type: object.class.name)
    end

    current_item
  end
end
