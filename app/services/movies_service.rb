class MoviesService 

  def top40
    acc = []
    get_json('/3/movie/top_rated?page=1')[:results].each do |movie|
      acc << movie
    end 
    get_json('/3/movie/top_rated?page=2')[:results].each do |movie|
      acc << movie
    end 
    @movies = acc.map{|info| MovieIndexObject.new(info)}
  end 

  private

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.themoviedb.org") do |faraday|
      faraday.params[:api_key] = ENV['MOVIES_API_KEY']
    end
  end
end 
#https://api.themoviedb.org/3/movie/top_rated?api_key=768c17292f63a7075f76e2c15d79d38f