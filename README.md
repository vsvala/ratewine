# Ratewine / Web-palvelinohjelmointi Ruby on Rails

 Helsingin yliopiston Web-palvelinohjelmointi Ruby on Rails(5 op) kurssilla (syksy-2018)  toteutettu web-sovellus. 
 - Toteutus: Herokun PostgreSQL tietokanta , Ruby on Rails -sovelluskehys.
 - Julkaisu: verkossa Heroku-pilvipalvelussa:https://wepa-ratewine.herokuapp.com/wineyards
 - Travis: [![Build Status](https://travis-ci.org/vsvala/ratewine.svg?branch=master)](https://travis-ci.org/vsvala/ratewine)
 - Koodin laadun valvonta ja laatumtriikat: Codeclimate:[![Maintainability](https://api.codeclimate.com/v1/badges/b70919286f2ca8dd8d12/maintainability)](https://codeclimate.com/github/vsvala/ratewine/maintainability)
 
 
 
# Ruby on Rails

- Rubyssä ORM-kirjaston: [ActiveRecordin  hakurajapinta](https://guides.rubyonrails.org/active_record_querying.html) tarjoaa mahdollisuudet tietokannan käsittelyyn ja hakujen tekemiseen ohjelmallisesti SQL:lää kirjoittamatta. 

- Riippuvuuksien hallinta: Rails-sovelluksen käyttämät kirjastot eli gemit on määritelty sovelluksen juuressa olevassa Gemfile-nimisessä tiedostossa. Riippuvuudet ladataan komentorivi komennolla bundle install.


# Ruby on Rails sovellus

- sovelluksen luominen: 
     - rails new "sovelluksen nimi" (Uusi Rails-sovellus luodaan generaattorilla new)
     - rails g scaffold brewery name:string year:integer (scaffold-generaattori luo kaikki tarvittavat tiedostopohjat
     nimettyinä ja sijoiteltuna Railsin konvention mukaisesti)
     - rails db:migrate (Tietokantataulun luonti) 
     
 - Serverin käynnistys ja sovelluksen suorittaminen
   - rails server /  rails s  (Komento käynnistää oletusarvoisesti Puma HTTP-palvelimen, joka alkaa suorittamaan hakemistossa  olevaa Rails-sovellusta paikallisen koneen (eli localhost:in) portissa 3000

- Rails konsoli
 -rails c  (avaa konsolin)
