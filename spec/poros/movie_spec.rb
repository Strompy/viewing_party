RSpec.describe Movie do
  before(:each) do
    @info = { id: 3,
             title: "Kill Bill",
             overview: "This rocks!",
             vote_average: 9.8,
             runtime: 125,
             genres: [{ name: "action"}, {name: "suspense"}, {name: "adventure"}] 
    }

    @cast = [{:name=>"Uma Thurman", 
             :character=>"Beatrix 'The Bride' Kiddo"}, 
             {:name=>"Lucy Liu", :character=>"O-Ren Ishii"}, 
             {:name=>"David Carradine", :character=>"Bill"}]

    @movie = Movie.new(@info, @cast)
  end 
  it "can be created with the appropriate info" do
    
    expect(@movie).to be_a (Movie)
    expect(@movie.title).to eq("Kill Bill")
    expect(@movie.id).to eq(3)
    expect(@movie.description).to eq("This rocks!")
    expect(@movie.vote_average).to eq(9.8)
    expect(@movie.runtime).to eq(125)
    expect(@movie.genres).to eq("action, suspense, adventure")   
  end
  describe "instance methods" do
    it "can return genres in formatted state" do
      
      expect(@movie.genres_formatting(@info[:genres])).to eq("action, suspense, adventure")
    end 
    it "can return formatted runtime" do   
      expect(@movie.runtime_formatted).to eq("2hr 5min")
    end 
    it "can return formatted cast" do   
      expect(@movie.formatted_cast(@cast)).to eq(["Uma Thurman as Beatrix 'The Bride' Kiddo", "Lucy Liu as O-Ren Ishii", "David Carradine as Bill"])
    end 
  end
end