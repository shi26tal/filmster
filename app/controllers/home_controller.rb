class HomeController < ApplicationController
  def index
    # User has entered a search query → fetch matching movies.
    # User hasn't entered a search query → fetch popular movies.
    if params[:query].present?
      # It expects a query argument.So we need to pass params[:query]
      # @movies = TmdbClient.new.search_movies(params[:query])["results"]

      @movies = MovieSearch.search_movies(params[:query])

      # Movie.save_search_results(@movies)
      # yoh duitai query movie_search.rb model ma handle garisakyo
    else
      # TmdbClient.new creates our API client.
      # .popular_movies calls TMDB and returns the parsed response. ["results"] extracts the array containing the 20 movies.
      # @movies makes that array available to home/index.html.erb.
      movies = TmdbClient.new.popular_movies["results"]

      # save them in postgres
      Movie.save_search_results(movies)
      # retrieves the saved actiive record object using their TMDB id
      @movies = Movie.where(tmdb_id: movies.map { |movie| movie["id"] })

    end

    @reviews = Review.order(created_at: :desc).limit(5)
  end
end
