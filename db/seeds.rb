# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


w1 = Wineyard.create name:"Bocopa", year:1897
w2 = Wineyard .create name:"Badet Clement", year:2001
w3 = Wineyard.create name:"Casa Santos Lima", year:1040

w1.wines.create name:"Laudum Nature Barrica Monastrell Petit Verdot 2015", style:"Red"
w2.wines.create name:"Evergreen Touch of Nature Monastrell Organic 2015", style:"Red"
w3.wines.create name:"OMG 2015", style:"Red"
w3.wines.create name:"Casa Santos Lima Fortíssimo 2015", style:"red"
w2.wines.create name:"Douce Nature Organic Chardonnay 2017", style:"White"


