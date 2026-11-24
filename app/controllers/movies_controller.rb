class MoviesController < ApplicationController
  # whensome one visit /movies/:id, rails calls the show action.
  # yoh detaiks return single movie hash so results array chaidaina
  def show
    # @movie = TmdbClient.new.movie_details(params[:id])

    # Instead of requesting TMDB every time, we're first retrieving the movie we already saved in PostgreSQL.
    # 404 response when the movie is not in our database.
    @movie = Movie.find_by!(tmdb_id: params[:id])

    if !@movie.tmdb_details_fetched?
      # if xaina bhaney api call garney for full details
      details = TmdbClient.new.movie_details(params[:id])
      @movie.update(
        # details hash contain many fields, but movies table only has certain columns
        # Rails cannot automatically save every TMDB field unless matching columns exist in your database.
        runtime: details["runtime"],
        budget: details["budget"],
        revenue: details["revenue"],
        tagline: details["tagline"],
        genres: details["genres"].map { |genre| genre["name"] },
        vote_average: details["vote_average"],
        vote_count: details["vote_count"],
        homepage: details["homepage"],
        tmdb_details_fetched: true
      )
    end
  end
end


# @movie: Existing movie record from PostgreSQL.
# details: Full movie details returned by TMDB.

# @movie.tmdb_details_fetched? returns true or false.
# ! reverses the result.
# So !true becomes false, and !false becomes true.
