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
    self.listing.update_column(:vote_count, vote_count['up'] - vote_count['down'])
  end
end
