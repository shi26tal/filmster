class HomeController < ApplicationController
  def index
    @movies = [
      {
        title: "Batman: Knightfall Part 1: Knightfall",
        poster: helpers.asset_path("batman.webp")
      },
      {
        title: "Avatar Aang: The Last Airbender",
        poster: helpers.asset_path("avatar.webp")
      },
      {
        title: "Swapped",
        poster: helpers.asset_path("swapped.webp")
      },
      {
        title: "Demon Slayer: Infinity Castle",
        poster: helpers.asset_path("demon.webp")
      },
      {
        title: "Accidental Partners",
        poster: helpers.asset_path("socias.webp")
      },
      {
        title: "Facing El Chapo",
        poster: helpers.asset_path("facing.webp")
      }
    ]
  end
end
