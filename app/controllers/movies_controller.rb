class MoviesController < ApplicationController
  # whensome one visit /movies/:id, rails calls the show action.
  # yoh detaiks return single movie hash so results array chaidaina
  def show
    @movie = TmdbClient.new.movie_details(params[:id])
  end
end
