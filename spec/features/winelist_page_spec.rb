# require 'rails_helper'

# describe "Winelist page" do
#   before :all do
#     Capybara.register_driver :selenium do |app|
#       capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
#         chromeOptions: { args: ['headless', 'disable-gpu']  }
#         )

#     Capybara::Selenium::Driver.new app,
#       browser: :chrome,
#       desired_capabilities: capabilities     
#     end
#     WebMock.disable_net_connect!(allow_localhost: true) 
#   end

#   before :each do
#     @wineyard1 = FactoryBot.create(:wineyard, name:"Koff")
#     @wineyard2 = FactoryBot.create(:wineyard, name:"Schlenkerla")
#     @wineyard3 = FactoryBot.create(:wineyard, name:"Ayinger")
#     @style1 = Style.create name:"Lager"
#     @style2 = Style.create name:"Rauchbier"
#     @style3 = Style.create name:"Weizen"
#     @wine1 = FactoryBot.create(:wine, name:"Nikolai", wineyard: @wineyard1, style:@style1)
#     @wine2 = FactoryBot.create(:wine, name:"Fastenbier", wineyard:@wineyard2, style:@style2)
#     @wine3 = FactoryBot.create(:wine, name:"Lechte Weisse", wineyard:@wineyard3, style:@style3)
#   end

#   it "shows one known wine", js:true do
#     visit winelist_path
#     # save_and_open_page
#     expect(page).to have_content "Nikolai"
#   end

#   it "confirms wines are ordered alphabetically", js:true do
#     visit winelist_path
#     find('table').find('tr:nth-child(2)')
#     # save_and_open_page
#     expect(page).to have_content "Fastenbier"
#   end

#   it "confirms styles are ordered alphabetically when style clicked", js:true do
#     visit winelist_path

#     click_link('style')
#     find('table').find('tr:nth-child(2)')
#     expect(page).to have_content "Lager"
#     # save_and_open_page
# end

# it "confirms wineyards are ordered alphabetically when wineyard clicked", js:true do
#   visit winelist_path

#   click_link('wineyard')
#   find('table').find('tr:nth-child(2)')
#   expect(page).to have_content "Ayinger"
#   save_and_open_page
# end
# end