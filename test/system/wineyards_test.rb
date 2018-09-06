require "application_system_test_case"

class WineyardsTest < ApplicationSystemTestCase
  setup do
    @wineyard = wineyards(:one)
  end

  test "visiting the index" do
    visit wineyards_url
    assert_selector "h1", text: "Wineyards"
  end

  test "creating a Wineyard" do
    visit wineyards_url
    click_on "New Wineyard"

    fill_in "Name", with: @wineyard.name
    fill_in "Year", with: @wineyard.year
    click_on "Create Wineyard"

    assert_text "Wineyard was successfully created"
    click_on "Back"
  end

  test "updating a Wineyard" do
    visit wineyards_url
    click_on "Edit", match: :first

    fill_in "Name", with: @wineyard.name
    fill_in "Year", with: @wineyard.year
    click_on "Update Wineyard"

    assert_text "Wineyard was successfully updated"
    click_on "Back"
  end

  test "destroying a Wineyard" do
    visit wineyards_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Wineyard was successfully destroyed"
  end
end
