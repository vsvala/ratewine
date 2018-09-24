require 'rails_helper'

RSpec.describe Wine, type: :model do
  it "is saved with name, style and wineyard" do
    test_wineyard = Wineyard.create name: "test", year: 2000
    wine = Wine.create name:"Plan B", style:"Red", wineyard:test_wineyard
    
    expect(wine.valid?).to be(true)
    expect(Wine.count).to eq(1)
  end

  it "is not saved without name" do
    test_wineyard = Wineyard.create name: "test", year: 2000
    wine = Wine.create style:"Red", wineyard:test_wineyard
    
    expect(wine.valid?).to be(false)
    expect(Wine.count).to eq(0)
  end

  it "is not saved without style" do
    test_wineyard = Wineyard.create name: "test", year: 2000
    wine = Wine.create name:"Plan B", wineyard:test_wineyard
    
    expect(wine.valid?).to be(false)
    expect(Wine.count).to eq(0)
  end



end
