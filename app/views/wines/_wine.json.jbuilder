# frozen_string_literal: true

json.extract! wine, :id, :name
json.style do
  json.name wine.style.name
end
json.wineyard do
  json.name wine.wineyard.name
end
