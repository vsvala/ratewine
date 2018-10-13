# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

w1 = Wineyard.create name: 'Bocopa', year: 1897
w2 = Wineyard .create name: 'Badet Clement', year: 2001
w3 = Wineyard.create name: 'Casa Santos Lima', year: 1040

w1.wines.create name: 'Laudum Nature Barrica Monastrell Petit Verdot 2015', style: 'Red'
w2.wines.create name: 'Evergreen Touch of Nature Monastrell Organic 2015', style: 'Red'
w3.wines.create name: 'OMG 2015', style: 'Red'
w3.wines.create name: 'Casa Santos Lima Fortíssimo 2015', style: 'red'
w2.wines.create name: 'Douce Nature Organic Chardonnay 2017', style: 'White'

# users = 200            # jos koneesi on hidas, riittää esim 200
# wineyards = 100         # jos koneesi on hidas, riittää esim 100
# wines_in_wineyard = 50
# ratings_per_user = 30

# (1..users).each do |i|
#   User.create! username: "user_#{i}", password:"Passwd1", password_confirmation: "Passwd1"
# end

# (1..wineyards).each do |i|
#   Wineyard.create! name:"Wineyard_#{i}", year: 1900, active: true
# end

# bulk = Style.create! name: "Bulk", description: "cheap, not much taste"

# Wineyard.all.each do |b|
#     n = rand(wines_in_wineyard)
#     (1..n).each do |i|
#       winee = Wine.create! name:"Wine #{b.id} -- #{i}", style:bulk
#       b.wines << winee
#     end
#   end

# User.all.each do |u|
#   n = rand(ratings_per_user)
#   wines = Wine.all.shuffle
#   (1..n).each do |i|
#     r = Rating.new score:(1+rand(50))
#     wines[i].ratings << r
#     u.ratings << r
#   end
end