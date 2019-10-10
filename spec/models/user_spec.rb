require 'rails_helper'

RSpec.describe User, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
describe "authenticate" do
  before do
    @user = User.create!(user_attributes)
  end

  it "returns non-true value if the email does not match" do
    expect(User.authenticate("nomatch", @user.password)).not_to eq(true)
  end

  it "returns non-true value if the password does not match" do
    expect(User.authenticate(@user.email, "nomatch")).not_to eq(true)
  end

  it "returns the user if the email and password match" do
    expect(User.authenticate(@user.email, @user.password)).to eq(@user)
  end

  it "has reviews" do
    user = User.new(user_attributes)
    movie1 = Movie.new(movie_attributes(title: "Iron Man"))
    movie2 = Movie.new(movie_attributes(title: "Superman"))
  
    review1 = movie1.reviews.new(stars: 5, comment: "Two thumbs up!")
    review1.user = user
    review1.save!
  
    review2 = movie2.reviews.new(stars: 3, comment: "Cool!")
    review2.user = user
    review2.save!
  
    expect(user.reviews).to include(review1)
    expect(user.reviews).to include(review2)
  end

  it "has favorite movies" do
    user = User.new(user_attributes)
    movie1 = Movie.new(movie_attributes(title: "Iron Man"))
    movie2 = Movie.new(movie_attributes(title: "Superman"))
  
    user.favorites.new(movie: movie1)
    user.favorites.new(movie: movie2)
  
    expect(user.favorite_movies).to include(movie1)
    expect(user.favorite_movies).to include(movie2)
  end
end