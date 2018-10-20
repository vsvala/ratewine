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


# Ruby on Rails sovelluksen luominen ja toiminta

 - Serverin käynnistys ja sovelluksen suorittaminen
   - rails server /  rails s  (Komento käynnistää oletusarvoisesti Puma HTTP-palvelimen, joka alkaa suorittamaan hakemistossa  olevaa Rails-sovellusta paikallisen koneen (eli localhost:in) portissa 3000

- Rails konsoli
 -rails c  (avaa konsolin)

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
     
 - Sovelluksen layout
   - Railsissa saadaan määriteltyä kaikille sivuille yhteiset osat sovelluksen layoutiin, eli tiedostoon
    app/views/layouts/application.html.erb. 
   - Navigointipalkin  saa näkyville kaikille sivuille sijoittamalla sen koodin sovelluksen layoutin body-elementtin sisään
   - Ulkoasua voi muotoilla app/assets/stylesheets/application.css  kautta
 
 
 - Reititys routes.rb
   - Railsin Routing-komponentin vastuulla on ohjata eli reitittää sovellukselle tulevien HTTP-pyyntöjen käsittely sopivan
   kontrollerin metodille eli tieto siitä miten eri URLeihin tulevat pyynnöt tulee reitittää, konfiguroidaan tiedostoon
   config/routes.rb
   - root 'wineyards#index' tekee viinitilojen listasta sovelluksen oletusarvoinen kotisivun' 
   - saman voi ilmaista: get '/', to: 'wineyards#index' eli reititä polulle '/' tuleva HTTP GET -pyyntö käsiteltäväksi luokan
   WineyardsController metodille index.
   
     
 - Lomakkeen luominen
    - Railsin metodi [form_for](http://guides.rubyonrails.org/form_helpers.html#dealing-with-model-objects)  muodostaa 
    automaattisesti oikeaan osoitteeseen lähetettävän, oikeanlaisen lomakkeem, jossa on syöttökentät kaikille parametrina
    olevan tyyppisen olion attribuuteille.
    - Railsin konventioiden mukaan Rating-olion luontiin tarkoitetun lomakkeen tulee löytyä osoitteesta ratings/new, ja
    lomakkeeseen pääsyn hoitaa ratings-kontrollerin metodi new.
    - get 'ratings/new', to:'ratings#new' Luo vastaavan reitin routes.rb:hen   http://localhost:3000/ratings/new
    -Luodaan nyt lomake näkymä eli tiedosto /app/views/ratings/new.html.erb:
       - <%= form_for(@rating) do |f| %>
       - beer id: <%= f.number_field :beer_id %>
       - score: <%= f.number_field :score %>
       - <%= f.submit %>
       - <% end %>
    - Uuden olion luonnista vastaava controllerin metodi on Railsin konvention mukaan nimeltään create
       - def create
       - raise
       -  end
    - Kun lomake lähetetään HTTP *POST-pyynnön parametrit sisältävän hashin, jonka sisällä välittyy lomakkeen tiedot.
    Parametrit sisältävä hash on kontrollerin sisällä talletettu muuttujaan params.Uuden ratingin tiedot ovat hashissa
    avaimen :rating arvona, eli pääsemme niihin käsiksi komennolla params[:rating] joka taas on hash jonka arvo on
    {"beer_id"=>"1", "score"=>"2"}. Eli esim. pistemäärään päästäisiin käsiksi komennolla params[:rating][:score].
    
 - Heroku yhteydet
