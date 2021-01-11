require 'rails_helper'

RSpec.describe "As a visitor" do
  describe "when I go the movie show page" do
    before(:each) do

      @info = {
        id: 393,
        title: "Kill Bill: Vol. 2",
        overview: "One of the best Tarantino films ever!",
        vote_average: 10,
        runtime: 136,
        genres: [{name: "Action"}, {name: "Suspense"}, {name: "Revenge"}]
      }

      @reviews = [{author: "Josh T", content: "This is a super fun film!"}, {author: "Phillip S", content: "Fun for the whole family!"}]

      @cast = [
        {
          name: "Uma Thurman",
          character: "Beatrix \'The Bride\' Kiddo"
        },
        {
          name: "Lucy Liu",
          character: "O-Ren Ishii"
        },
        {
          name: "David Carradine",
          character: "Bill"
        }
      ]

      @movie = Movie.new(@info, @cast)
    end

    it "I will see a description, vote average, run time, genres, cast and reviews for film" do
      allow_any_instance_of(MoviesService).to receive(:film_info).and_return(@info)
      allow_any_instance_of(MoviesService).to receive(:cast).and_return(@cast)
      allow_any_instance_of(MoviesService).to receive(:movie_reviews).and_return(@reviews)

      visit "/movies/#{@movie.id}"

      expect(page).to have_content('Kill Bill: Vol. 2')

      within(".description") do
        expect(page).to have_content('One of the best Tarantino films ever!')
      end

      within(".vote_average") do
        expect(page).to have_content(10)
      end

      within(".runtime") do
        expect(page).to have_content("2hr 16min")
      end

      within(".genres") do
        expect(page).to have_content("Genres: Action, Suspense, Revenge")
      end

      within(".cast") do
        expect(page).to have_content("Uma Thurman as Beatrix 'The Bride' Kiddo")
        expect(page).to have_content("Lucy Liu as O-Ren Ishii")
        expect(page).to have_content("David Carradine as Bill")
      end

      within(".reviews") do
        expect(page).to have_content("Author: Josh T")
        expect(page).to have_content("This is a super fun film!")
        expect(page).to have_content("Author: Phillip S")
        expect(page).to have_content("Fun for the whole family!")
      end

      within('.viewing-party') do
        expect(page).to have_link("Create Viewing Party for Kill Bill: Vol. 2")
      end
    end
  end
end
