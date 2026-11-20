class MoviesController < ApplicationController
  # whensome one visit /movies/:id, rails calls the show action.
  # temporay data
  def show
    @movie = {
      title: "Batman: Knightfall Part 1: Knightfall",
      genres: [ "Drama", "Thriller" ],
      poster: helpers.asset_path("batman.webp"),
      description: "Arkham Asylum has been destroyed, and all its inmates have been unleashed upon Gotham City. As Batman races to round up some of his greatest enemies, he is pushed to his physical and mental limits and into a final confrontation with a new threat: the man called Bane!",
      duration: "1h 16m",
      released_date: "2025-10-14",
      popularity: 125.45
    }
  end
end
