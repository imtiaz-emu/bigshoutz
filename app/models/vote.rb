# == Schema Information
#
# Table name: votes
#
#  id         :bigint           not null, primary key
#  user_id    :integer
#  listing_id :integer
#  vote_type  :boolean
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  total      :integer          default(1)
#
class Vote < ApplicationRecord
  belongs_to  :user
  belongs_to  :listing

  validates :vote_type, inclusion: { in: %w[ up down ] }

  enum vote_type: { up: true, down: false }

  scope :upvotes, -> { where(vote_type: true) }
  scope :downvotes, -> { where(vote_type: false) }

  after_save :update_listing
  after_destroy :update_listing

  private

  def update_listing
    vote_count = self.listing.votes.group(:vote_type).sum(:total)
    vote_diff = (vote_count['up'] || 0) - (vote_count['down'] || 0)
    self.listing.update_column(:vote_count, vote_diff)
  end
end
