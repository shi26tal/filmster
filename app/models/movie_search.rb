class MovieSearch < ApplicationRecord
  # means one search can have many joining records.
  has_many :movie_search_results

  # means one search can access all its associated movies through the joining table.
  has_many :movies, through: :movie_search_results

  # We'll call it directly using the model name
  def self.search_movies(query)
    search = MovieSearch.find_by(query: query)
    if search
      search.movies
    else
      movies = TmdbClient.new.search_movies(query)["results"]

      Movie.save_search_results(movies)
      # query search record create garxa
      # create new MovieSearch object and saves it immediately in postgresSQL
      search = MovieSearch.create!(query: query)

      # associate movies with search query
      movies.each do |movie|
        movie_record = Movie.find_by(tmdb_id: movie["id"])

        search.movies << movie_record
      end

      # This retrieves all movies associated with the newly created search.
      search.movies
    end
  end
end


# Checks PostgreSQL for an existing search.
# If found, returns cached movies.
# If not found, fetches movies from TMDB.
# Saves movies and their search associations.
# Returns the movies.
