class LineItem < ApplicationRecord
  belongs_to :line_item_able, polymorphic: true
  belongs_to :cart
end
