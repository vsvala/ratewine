require 'rails_helper'
require 'helpers'

include Helpers

describe "Rating" do
  let!(:wineyard) { FactoryBot.create :wineyard }
  let!(:style2) { FactoryBot.create :style}
  let!(:wineyard2) { FactoryBot.create :wineyard, name:"TokaViinitila" }
  let!(:style) { FactoryBot.create :style, name:"Red", description:'kuvaus' } 
  let!(:wine1) { FactoryBot.create :wine, name:"Viini1", wineyard:wineyard, style:style2 }
  let!(:wine2) { FactoryBot.create :wine, name:"Viini2", wineyard:wineyard2, style:style2 }
  let!(:user) { FactoryBot.create :user }
  let!(:user2) { FactoryBot.create :user, username:"Pasi", password:"Foobar2", password_confirmation: "Foobar2" }
  let!(:rating1) { FactoryBot.create :rating, wine:wine2,  score: 20, user:user}
  let!(:rating2) { FactoryBot.create :rating, wine:wine2,  score: 30, user:user}
  let!(:rating3) { FactoryBot.create :rating, wine:wine1,  score: 5, user:user}
  let!(:rating4) { FactoryBot.create :rating, wine:wine1,  score: 25, user:user2}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "rating page shows given ratings and counts them" do
    visit ratings_path

    expect(Rating.count).to eq(4)
    expect(page).to have_content 'Viini2, 20'
    expect(page).to have_content 'Viini2, 30'
    expect(page).to have_content 'Viini1, 5'
    expect(page).to have_content 'Viini1, 25'
  end

  it "when rating given, is registered to the wine and user who is signed in and show it on his page" do
    visit new_rating_path
    # save_and_open_page
    select('Viini1', from:'rating[wine_id]')
    fill_in('rating[score]', with:'15')

    expect{
      click_button "Create Rating"
    }.to change{Rating.count}.from(4).to(5)

    expect(user.ratings.count).to eq(4)
    expect(page).to have_content 'Viini2, 20'
    expect(page).to have_content 'Viini2, 30'
    expect(page).to have_content 'Viini1, 5'
    expect(page).to have_content 'Viini1, 15'
    expect(page).to have_content 'Has 4 ratings, average 17.5'
    # expect(wine1.ratings.count).to eq(3)
    # expect(wine1.average_rating).to eq("Has 3 ratings, average 23.3333333333333")
    #save_and_open_page
  end

  it "when rating is deleted, it deletes it from database" do
    
    visit user_path(user)

    expect{ first(:link, 'delete').click }.to change{user.ratings.count}.from(3).to(2)
    expect(user.ratings.count).to eq(2)
    expect(page).to have_content 'Viini2, 30'
    expect(page).to have_content 'Viini1, 5'
    expect(page).to have_content 'Has 2 ratings'
    #save_and_open_page
  end

  it "when ratings has made, page shows favourite winestyle and favourite wineyard" do  
    visit user_path(user)

    expect(page).to have_content 'Favorite wine style:Red'
    expect(page).to have_content 'Favorite wineyard:TokaViinitila'
    #save_and_open_page
  end
end