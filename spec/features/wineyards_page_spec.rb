require 'rails_helper'

describe "Wineyards page" do
  it "should not have any wineyards listed before been created" do
    visit wineyards_path
    # save_and_open_page
    expect(page).to have_content 'Number of active wineyards: 0'
  end

  describe "when wineyards exists" do
    before :each do
        # jotta muuttuja näkyisi it-lohkoissa, tulee sen nimen alkaa @-merkillä
        @wineyards = ["Viinitila", "Tila2", "Tila3"]
        year = 1896
        @wineyards.each do |wineyard_name|
        FactoryBot.create(:wineyard, name: wineyard_name, year: year += 1)
        end

        visit wineyards_path
    end

    it "lists the existing wineyards and their total number" do
        expect(page).to have_content "Number of active wineyards:" # #{@active_wineyards.count}
        # save_and_open_page
        @wineyards.each do |wineyard_name|
        expect(page).to have_content wineyard_name
    end
  end

  it "allows user to navigate to page of a Winayard" do
    click_link "Viinitila"

    # save_and_open_page

    expect(page).to have_content "Viinitila"
    expect(page).to have_content "Established at 1897"
  end
end
end
