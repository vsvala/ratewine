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
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
    let(:test_wineyard) { Wineyard.new name: "test", year: 2000 }
    let(:test_wine) { Wine.create name: "testwine", style: "teststyle", wineyard: test_wineyard }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "with a proper password and two ratings, has the correct average rating" do
      rating = Rating.new score: 10, wine: test_wine
      rating2 = Rating.new score: 20, wine: test_wine
  
      user.ratings << rating
      user.ratings << rating2
  
      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq('Has 2 ratings, average 15.0')
    end  
  end
end