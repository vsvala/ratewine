require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    # expect(user).not_to be_valid
    # expect(user.valid?).to eq(false)
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved if password is formed just with letters" do
    user=User.create username:"Pekka", password:"kkkkk", password_confirmation:"kkkkk"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  it "is not saved with too short password" do
    user=User.create username:"Pekka", password:"k1", password_confirmation:"k1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ FactoryBot.create(:user) }
  
    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "with a proper password and two ratings, has the correct average rating" do
      FactoryBot.create(:rating, score: 10, user:user)
      FactoryBot.create(:rating, score: 20, user: user)
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq("15.0")
    end  
  end

  describe "favorite wine" do
    let(:user){ FactoryBot.create(:user) }
  
  
  it "has method for determining one" do
    expect(user).to respond_to(:favorite_wine)
  end

  it "without ratings does not have one" do
    expect(user.favorite_wine).to eq(nil)
  end

  it "is the only rated if only one rating" do
    wine = FactoryBot.create(:wine)
    rating = FactoryBot.create(:rating, score: 20, wine: wine, user: user)
    
    expect(user.favorite_wine).to eq(wine)
  end

  it "is the one with highest rating if several rated" do
    create_wine_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
    best = create_wine_with_rating({ user: user }, 25 )

    expect(user.favorite_wine).to eq(best)
  end    
end

end # describe User



describe "favorite style" do
  let(:user){ FactoryBot.create(:user) }


it "has method for determining one" do
  expect(user).to respond_to(:favorite_wine_style)
end

it "without ratings does not have one" do
  expect(user.favorite_wine_style).to eq(nil)
end

it "is the only rated if only one rating" do
  wine = FactoryBot.create(:wine)
  rating = FactoryBot.create(:rating, score: 20, wine: wine, user: user)
  
  expect(user.favorite_wine_style).to eq(wine.style.name)
end

it "is the one with highest rating if several rated" do
  create_wine_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
  best = create_wine_with_rating({ user: user }, 25 )

  expect(user.favorite_wine_style).to eq(best.style.name)
end    
end # describe User

describe "favorite wineyard" do
  let(:user){ FactoryBot.create(:user) }


it "has method for determining one" do
  expect(user).to respond_to(:favorite_wineyard)
end

it "without ratings does not have one" do
  expect(user.favorite_wineyard).to eq(nil)
end

it "is the only rated if only one rating" do
  wine = FactoryBot.create(:wine)
  rating = FactoryBot.create(:rating, score: 20, wine: wine, user: user)
  
  expect(user.favorite_wineyard).to eq(wine.wineyard.name)
end

it "is the one with highest rating if several rated" do
  create_wine_with_many_ratings({user: user}, 10, 20, 15, 7, 9)
  best = create_wine_with_rating({ user: user }, 25 )

  expect(user.favorite_wineyard).to eq(best.wineyard.name)
end    
end # describe User

  def create_wine_with_rating(object, score)
    wine = FactoryBot.create(:wine)
  FactoryBot.create(:rating, wine: wine, score: score, user: object[:user] )
  wine
  end

def create_wine_with_many_ratings(object, *scores)
  scores.each do |score|
    create_wine_with_rating(object, score)
end
end
