require 'rails_helper'

describe "Places" do
  it "if one is returned by the API, it is shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("kumpula").and_return(
      [ Place.new( name:"Oljenkorsi", id: 1 ) ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if all are returned by the API, they are shown at the page" do
    allow(BeermappingApi).to receive(:places_in).with("helsinki").and_return(
      [ Place.new( name:"Kaisla", id: 1),  Place.new( name:"Hilpeä Hauki", id: 2 ) ]
    )
 
    visit places_path
    fill_in('city', with: 'helsinki')
    click_button "Search"
    #save_and_open_page
    expect(page).to have_content "1 Kaisla 2 Hilpeä Hauki"
  end

  it "if API doesnt find any places and returns empty array" do
    allow(BeermappingApi).to receive(:places_in).with("kuopio").and_return(
      [ ]
    )
    visit places_path
    fill_in('city', with: 'kuopio')
    click_button "Search"
 
    save_and_open_page

   expect(page).to have_content "No locations in kuopio"
  end
end
