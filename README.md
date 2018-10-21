# Ratewine / Web-palvelinohjelmointi Ruby on Rails

 Helsingin yliopiston [Web-palvelinohjelmointi Ruby on Rails(5 op)](https://github.com/mluukkai/WebPalvelinohjelmointi2018/blob/master/wadror.md) kurssilla (syksy-2018)  toteutettu web-sovellus. 
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
   - rails server /  rails s  (Komento käynnistää oletusarvoisesti Puma HTTP-palvelimen, joka alkaa suorittamaan hakemistossa
   olevaa Rails-sovellusta paikallisen koneen (eli localhost:in) portissa 3000

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
       -   Rating.create params.require(:rating).permit(:score, :wine_id)
       -   redirect_to ratings_path '#ratings_path on Railsin tarjoama polkuapumetodi, joka tarkoittaa samaa kuin "/ratings"
       -  end
    - Kun lomake lähetetään HTTP *POST-pyynnön parametrit sisältävän hashin, jonka sisällä välittyy lomakkeen tiedot
    params[:rating], kyseess on hash, joka on muotoa {"wine_id"=>"1", "score"=>"30"}
    -Tietoturvasyistä Rails ei kuitenkaan salli mielivaltaista params-muuttujasta tapahtuvaa "massasijoitusta" 
    (engl. mass assignment eli kaikkien parametrien antamista hashina) olion luomisen yhteydessä, eli  
    Rating.create params[:rating] ei toimi. Rails 4:stä lähtien kontrollerin on lueteltava eksplisiittisesti mitä
    hashin params sisällöstä voidaan massasijoittaa olioiden luonnin yhteydessä. Tähän kontrolleri käyttää params:in
    metodeja require ja permit.
    - redirect_to ratings_path uudelleenohjauksessa palvelin lähettää selaimelle statuskoodilla 302 varustetun vastauksen,
    joka ei sisällä  HTML:ää. Vastaus sisältää vain osoitteen, mihin selain tekee automaattisesti uuden HTTP GET -pyynnön. 

- -Polkuapumetodit
  - Rails luo automaattisesti kaikille tiedostoon routes.rb määritellyille reiteille ns. polkuapumetodit (engl. path helper)
  ei siis ole tarvetta ratings_path-apufunktion sijaan kovakoodata:  redirect_to 'ratings'
  - rails routes komentorivikomennolla pääsee tarkastelemaan näitä automaattisesti generoituja polkuja
  

- [Autentikonti](https://github.com/vsvala/ratewine/blob/master/Dokumentaatio/Autentikointi.md)

### Rubocob, tyylin tarkastus 
- Koodin tyylin tarkastuksessa on käytetty  Rubocopia, jonka avulla voimme määritellä koodilemme tyylisäännöstön ja seurata,
että pidättäydymme säännöstön mukaisessa koodissa.Kun Rubocop on asennettu komentorivin käskyllä: gem install rubocop, voi
tyylitarkastuksen suorittaa koko koodille tai yksittäiselle tiedostolle seuraavilla komentoriviltä komennolla: 
 - rubocop
 - rubocop app/models/wine.rb

- Sääntöjen [dokumentaatiosta](http://docs.rubocop.org/en/latest/cops/) voi selvittää tyylivirheiden syitä

- Rubocopin tarkastama säännöstö määritellään projektin juureen sijoitettavassa tiedostossa .rubocop.yml. Tiedoston määrittelemä säännöstö perustuu Relaxed Ruby -tyyliin, jota se tiukentaa muutamien sääntöjen osalta. Tiedostossa myös jätetääm osa projektin tiedostoista tyylitarkastuksen ulkopuolelle.

### Debuggaus
- Rails on jo konfiguroinut sovelluksesi käyttöön [byebug-debuggerin](http://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-byebug-gem) ja railsin web-konsolin. 
Jos lisäät koodiin komennon binding.pry voit käyttää Pry:tä debuggerina:kun koodirivi suoritetaan, suoritus pysähtyy ja Pry-sessio aukeaa koodirivin kohdalle. Voit jatkaa suoritusta komennolla exit

- Byebugia käytettäessä lisätään kontrollerin alkuun, eli sille kohtaan koodia jota haluamme tarkkailla, komento byebug, jolloin sovellus pysähtyy komennon byebug kohdalle.  Terminaaliin josta Rails on käynnistetty, avautuu interaktiivinen konsolinäkymä.Debuggerin konsolissa voi  suorittaa koodia Rails-konsolin tavoin.Debuggerin tärkeimmät komennot lienevät step, next, continue ja help.

- Rails on sisältänyt versiosta 4.2 alkaen oletusarvoisesti debuggerin tapaan toimivan web-konsolin. Konsolinäkymä avautuu
automaattisesti jos ohjelmassa syntyy poikkeus. Poikkeuksen voi "aiheuttaa" esim. kirjoittamalla mihin tahansa kohtaan
koodia raise. Jos lisäät koodiin komennon binding.pry voit käyttää Pry:tä debuggerina:kun koodirivi suoritetaan, suoritus pysähtyy ja Pry-sessio aukeaa koodirivin kohdalle. Voit jatkaa suoritusta komennolla exit

-prystä poistutaan komennolla exit ja byebugista komennolla c

-Jos käytössäsi on Pry komento byebug ei käyttäydy kaikissa tilanteissa hyvin, kannattaakin käyttää oikeastaan aina komentoa
binding.pry
    
 ### [Heroku yhteydet](https://github.com/vsvala/ratewine/blob/master/Dokumentaatio/Heroku%20yhteydet.md)
