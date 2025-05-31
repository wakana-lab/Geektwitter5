class Like < ApplicationRecord
  belongs_to :tweet
  validates_uniqueness_of :tweet_id, scope: :user_id
  belongs_to :user
end
