# == Schema Information
#
# Table name: comments
#
#  id          :bigint           not null, primary key
#  user_id     :integer
#  listing_id  :integer
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Comment < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates_presence_of :description
end
