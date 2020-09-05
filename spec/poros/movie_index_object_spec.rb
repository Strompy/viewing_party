require 'rails_helper'

RSpec.describe MovieIndexObject do
  it "can be created with the appropriate info" do
    info = { title: "Kill Bill",
             vote_average: 9.9,
             id: 3}

    movie_index_obj = MovieIndexObject.new(info)

    expect(movie_index_obj).to be_a (MovieIndexObject)
    expect(movie_index_obj.title).to eq("Kill Bill")
    expect(movie_index_obj.vote_average).to eq(9.9)
    expect(movie_index_obj.id).to eq(3)
  end
end