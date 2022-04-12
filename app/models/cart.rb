class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  # object can be either Listing or Addon
  def add_item(object)
    if object.is_a?(Listing)
      current_item = line_items.find_by(listing_id: object.id)
    else
      current_item = line_items.find_by(addon_id: object.id)
    end

    if current_item
      current_item.quantity += 1
    else
      current_item = if object.is_a?(Listing)
                       line_items.build(listing_id: object.id)
                     else
                       line_items.build(addon_id: object.id)
                     end
    end

    current_item
  end
end
