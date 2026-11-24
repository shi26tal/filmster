class ReviewsController < ApplicationController
  before_action :authenticate_user, only: [ :create ]
  def create
    # find the movie using its tmdb id
    # ! raises the error if movie doesnot exist
    @movie = Movie.find_by!(tmdb_id: params[:movie_id])

    # build doesnot save until we call .save
    @review = @movie.reviews.build(
      user: current_user,
      # this access the review content submitted through the form
      # like reviews ko ni content
      content: params[:review][:content]
    )

    if @review.save
      redirect_to movie_path(@movie.tmdb_id), notice: "Reviews added succeddfully"
    else
      redirect_to movie_path(@movie.tmdb_id), alert: "Could not post your review"
    end
  end
end
