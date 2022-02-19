class Vote < ApplicationRecord
  belongs_to  :user
  belongs_to  :listing

  validates :vote_type, inclusion: { in: %w[ up down ] }

  enum vote_type: { up: true, down: false }

  after_save :update_listing
  after_destroy :update_listings

  private

  def update_listing
    self.listing.update_column(:vote_count, self.listing.votes.length)
  end
end
