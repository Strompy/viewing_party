require 'rails_helper'

RSpec.describe "As a registered user" do
  describe "when I have scheduled viewing parties" do
    before :each do
      @user = User.create!(username: "Quentin", email: "tarantino@gmail.com")
      @user2 = User.create!(username: "Francis", email: "coppola@wine.com")
      @user3 = User.create!(username: "Martin", email: "scorsese@hotmail.com")

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      @info = {
        id: 393,
        title: "Kill Bill: Vol. 2",
        overview: "One of the best Tarantino films ever!",
        vote_average: 10,
        runtime: 136,
        genres: [{name: "Action"}, {name: "Suspense"}, {name: "Revenge"}]
      }

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
      @party = @user.view_parties.create!(date: "2020-08-28", time: "07:00", movie_title: @movie.title, runtime: @movie.runtime, host: @user.username)
      @party.users << @user2
      @party.users << @user3
      @user2.rsvp(@party)
    end

    it "I can go to the viewing party show page from the dashboard" do
      visit dashboard_path

      within ".view-party" do
        click_button("Party Details")
      end

      expect(current_path).to eq(dashboard_viewing_party_path(@party.id))
    end
 end
end
