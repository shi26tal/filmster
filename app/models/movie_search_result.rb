class MovieSearchResult < ApplicationRecord
  belongs_to :movie_search
  belongs_to :movie
end
