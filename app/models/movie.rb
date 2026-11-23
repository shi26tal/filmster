
class Movie < ApplicationRecord
    has_many :movie_search_results
    has_many :movie_searches, through: :movie_search_results

  # create a class method Because we'll call it directly on the Movie class. We don't need to create an individual Movie object before calling it.
  # saving logic
  def self.save_search_results(movies)
    movies.each do |movie|
      movie_record = Movie.find_or_initialize_by(tmdb_id: movie["id"])

      # aailey search results matra save gardai so not full details fields
      movie_record.assign_attributes(
        title: movie["title"],
        overview: movie["overview"],
        poster_path: movie["poster_path"],
        release_date: movie["release_date"],
        popularity: movie["popularity"]
      )

      movie_record.save
    end
  end
end
