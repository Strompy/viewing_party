class MoviesService
  def top40
    acc = []
    get_json('/3/movie/top_rated?page=1')[:results].each do |movie|
      acc << movie
    end
    get_json('/3/movie/top_rated?page=2')[:results].each do |movie|
      acc << movie
    end
    acc
  end

  def film_info(id)
    get_json("/3/movie/#{id}")
  end

  def cast(id)
    get_json("/3/movie/#{id}/credits")[:cast]
  end

  def movie_reviews(id)
    get_json("/3/movie/#{id}/reviews")[:results]
  end

  def search(keyword)
    acc = []
    get_json("/3/search/movie?query=#{keyword}&page=1")[:results].each do |movie|
      acc << movie
    end
    unless get_json("/3/search/movie?query=#{keyword}&page=2")[:results].nil?
      get_json("/3/search/movie?query=#{keyword}&page=2")[:results].each do |movie|
        acc << movie
      end
    end
    acc 
  end

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new('https://api.themoviedb.org') do |faraday|
      faraday.params[:api_key] = ENV['MOVIES_API_KEY']
    end
  end
end
