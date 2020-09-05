class MovieFacade
  attr_reader :keyword, :movies
  def initialize(keyword = nil)
    @keyword = keyword
    @movie_service = MoviesService.new
    @movies = movie_search(keyword)
  end

  def movie_result(id)
    movie_details = @movie_service.film_info(id)
    cast = @movie_service.cast(id)
    Movie.new(movie_details, cast)
  end 

  def movie_reviews(id)
    reviews_info = @movie_service.movie_reviews(id)
    reviews_info.map { |review| FilmReview.new(review) }
  end 

  def movie_search(keyword)
    if keyword.blank?
      @movies = @movie_service.top40
      movies.map { |info| MovieIndexObject.new(info) }
    else
      movies = @movie_service.search(keyword)
      movies.map { |info| MovieIndexObject.new(info) }
    end
  end 
end 