# frozen_string_literal: true

json.extract! wineyard, :id, :name, :year, :active
json.wine do
  json.count wineyard.wines.count
end
