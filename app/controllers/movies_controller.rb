class MoviesController < ApplicationController
  # whensome one visit /movies/:id, rails calls the show action.
  # temporay data
  def show
    @movie = {
      title: "Batman: Knightfall Part 1: Knightfall",
      genres: [ "Drama", "Thriller" ],
      poster: helpers.asset_path("batman.webp")
    }
  end
end
