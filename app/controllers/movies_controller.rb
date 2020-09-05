class MoviesController < ApplicationController
  def index
    @movies = MovieFacade.new(params[:keyword])
  end

  def show
    id = params[:id]
    @movie = MovieFacade.new.movie_result(id)
    @reviews = MovieFacade.new.movie_reviews(id)
  end
end
