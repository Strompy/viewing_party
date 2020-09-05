require 'rails_helper'

RSpec.describe MoviesService do
  describe "instance methods", :vcr do 

    before(:each) do
      @service = MoviesService.new
    end

    it "can return the top rated 40 films" do

      blockbusters = @service.top40
      
      expect(@service).to be_a(MoviesService)
      expect(blockbusters.count).to eq(40)
      expect(blockbusters.first[:title]).to be_a(String)
      expect(blockbusters.first[:vote_average]).to be_a(Float)
    end

    it "can return film_info" do

      id = 393

      film_info = @service.film_info(id)
      expect(film_info[:genres]).to be_an(Array)
      expect(film_info[:id]).to be_an(Integer)
      expect(film_info[:title]).to be_an(String)
      expect(film_info[:vote_average]).to be_a(Float)
      expect(film_info[:runtime]).to be_an(Integer)
      expect(film_info[:overview]).to be_a(String)

    end

    it "can return a list of cast members" do

      id = 393

      cast = @service.cast(id)

      expect(cast).to be_an(Array)
      expect(cast.first[:character]).to be_a(String)
      expect(cast.first[:name]).to be_a(String)
    end

    it "can return a list of reviews for a movie" do

      id = 393

      reviews = @service.movie_reviews(id)

      expect(reviews).to be_an(Array)
      expect(reviews.first[:author]).to be_a(String)
      author = reviews.first[:author]
      expect(author).to_not be_empty
      expect(reviews.first[:content]).to be_a(String)
    end

    it "can create a movie object with film_info and cast" do

      id = 393

      film_info = @service.film_info(id)
      cast = @service.cast(id)

      movie = Movie.new(film_info, cast)

      expect(movie).to be_a(Movie)
      expect(movie.id).to be_an(Integer)
      expect(movie.title).to be_a(String)
      expect(movie.vote_average).to be_a(Float)
    end
  end
end
