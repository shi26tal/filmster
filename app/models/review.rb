class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :content, :user_id, :movie_id,  presence: true
end
