# == Schema Information
#
# Table name: line_items
#
#  id                  :bigint           not null, primary key
#  line_item_able_id   :integer
#  line_item_able_type :string
#  cart_id             :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  quantity            :integer          default(1)
#
class LineItem < ApplicationRecord
  belongs_to :line_item_able, polymorphic: true
  belongs_to :cart

  def total_price
    line_item_able.price * quantity
  end
end
