require 'rails_helper'

RSpec.describe FilmReview do
  it "can be created with the appropriate info" do
    info = { author: "Ernest Hemmingway",
             content: "This movie is a classic"
    }

    review = FilmReview.new(info)

    expect(review).to be_a (FilmReview)
    expect(review.author).to eq("Ernest Hemmingway")
    expect(review.content).to eq("This movie is a classic")
  end
end