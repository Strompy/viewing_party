require 'rails_helper'

RSpec.describe ViewPartyMovie do
  it "can be created with the appropriate info" do
    title = "Kill Bill"
    runtime = 125
            

    view_party_movie = ViewPartyMovie.new(title, runtime)

    expect(view_party_movie).to be_a (ViewPartyMovie)
    expect(view_party_movie.title).to eq("Kill Bill")
    expect(view_party_movie.runtime).to eq(125)
  end
end