# Ratewine / Web-palvelinohjelmointi Ruby on Rails

 Helsingin yliopiston Web-palvelinohjelmointi Ruby on Rails(5 op) kurssilla (syksy-2018)  toteutettu web-sovellus. 
 - Toteutus: Herokun PostgreSQL tietokanta , Ruby on Rails -sovelluskehys.
 - Julkaisu: verkossa Heroku-pilvipalvelussa:https://wepa-ratewine.herokuapp.com/wineyards
 - Travis: [![Build Status](https://travis-ci.org/vsvala/ratewine.svg?branch=master)](https://travis-ci.org/vsvala/ratewine)
 - Koodin laadun valvonta ja laatumtriikat: Codeclimate:[![Maintainability](https://api.codeclimate.com/v1/badges/b70919286f2ca8dd8d12/maintainability)](https://codeclimate.com/github/vsvala/ratewine/maintainability)
 
 
 
# Ruby on Rails

- Rubyssä ORM-kirjaston: [ActiveRecordin  hakurajapinta](https://guides.rubyonrails.org/active_record_querying.html) tarjoaa mahdollisuudet tietokannan käsittelyyn ja hakujen tekemiseen ohjelmallisesti SQL:lää kirjoittamatta. 

- Riippuvuuksien hallinta: Rails-sovelluksen käyttämät kirjastot eli gemit on määritelty sovelluksen juuressa olevassa Gemfile-nimisessä tiedostossa. Riippuvuudet ladataan komentorivi komennolla bundle install.
   - Eri ysuorimpäristöjen(development, test, produktion) käyttämät gemit voidaan määritellä Gemfilessä group-lohkojen avulla


# Ruby on Rails sovellus

- sovelluksen luominen: 
     - rails new "sovelluksen nimi" (Uusi Rails-sovellus luodaan generaattorilla new)
     - rails g scaffold wineyard name:string year:integer (scaffold-generaattori luo kaikki tarvittavat tiedostopohjat
     nimettyinä ja sijoiteltuna Railsin konvention mukaisesti)
     - rails db:migrate (Tietokantataulun luonti) 
     - rails db:rollback peruu migraation ja rails destroy scaffold wineyard,poistaa generoidun koodin 
     - Olion voi luoda ja tallettaa suoraan kantaan metodilla create, esim Wineyard.create name:"Viinitila1", year:"2000"
     - Yhdestä moneen tietokanta liitokset saadaan luotua lisäämällä modeleihin esim. Wine-luokkaan rivi 
     belongs_to:wineyard ja Wineyard luokkaan has_many :wines. Lisäksi viinille täytyy luoda integer-tyyppinen kenttä b
     wineyard_id, joka toimii vierasavaimena (foreign key). 
     - orvot = Wine.all.select{ |b| b.wineyard.nil? }, orvot.each{ |orpo| orpo.delete (orvoksi jääneiden olioien poisto)
 
 - Kontrollerin ja näkymä templatin view toiminta 
     - Kontrolleri luokassa kaikkien panimoiden listaa, eli osoitetta /wineyards hallinnoi metodi index joka renderöi
     automaattisesti näkymätemplatessa app/views/breweries/index.html.erb määritellyn html-sivun
     - Metodi show renderöi näkymätemplaten show.html.erb, joka huolehtii yksittäisen olion näkymästä esim. /wineyards/3
     - Eksplisiittinen render-metodin kutsuminen on tarpeen vain silloin kun kontrolleri renderöi jonkin muun kuin
     oletusnäkymän.
     - Näkymätemplatet, eli erb-tiedostot ovat html:ää, joihin on upotettu Ruby-koodia <% %> merkkien sisälle. <%= %> taas
     aiheuttaa Ruby-komennon arvon tulostumisen ruudulle.
     - @wineyard= Brewery.all kaikkien viinitilojen listan haku kannasta ja tallennus muuttujaan
     - @wineyard = Wineyard.find(params[:id]) yksittäisen olion haku kannasta
     - Linkin generointi:<%= link_to "linkki viintilaan #{wineyard.name}", wineyard %> 
     tai <%= link_to "linkki panimoon #{brewery.name}", brewery_path(brewery.id) %>
     
 - Serverin käynnistys ja sovelluksen suorittaminen
   - rails server /  rails s  (Komento käynnistää oletusarvoisesti Puma HTTP-palvelimen, joka alkaa suorittamaan hakemistossa  olevaa Rails-sovellusta paikallisen koneen (eli localhost:in) portissa 3000

- Rails konsoli
 -rails c  (avaa konsolin)
 
 - Heroku yhteydet
