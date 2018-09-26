require 'rails_helper'

describe "wine" do
let!(:wineyard) { FactoryBot.create :wineyard, name:"Viinitila" }
let!(:user2) { FactoryBot.create :user, username:"Pekka", password:"Foobar1", password_confirmation: "Foobar1" }

before :each do
  sign_in(username:"Pekka", password:"Foobar1")
end
it "is added if name and style field is valid" do

    visit new_wine_path
    # save_and_open_page

    fill_in('Name', with:'TestiViini')
    select('Red', from:'wine[style]')
    select('Viinitila', from:'wine[wineyard_id]')
    
    expect{
      click_button('Create Wine')
    }.to change{Wine.count}.by(1)
    # save_and_open_page
  end

  it "is not added to db and gives error msg if name and style field aren't valid" do

    visit new_wine_path
    # save_and_open_page

    fill_in('Name', with:'')
    select('Red', from:'wine[style]')
    select('Viinitila', from:'wine[wineyard_id]')
    
    expect{
      click_button('Create Wine')}.to change{Wine.count}.by(0)
      expect(page).to have_content 'Name can\'t be blank'
      #save_and_open_page
  end
end