class Vote < ApplicationRecord
  belongs_to  :user
  belongs_to  :listing

  enum vote_type: { up: 1, down: 0 }
end
