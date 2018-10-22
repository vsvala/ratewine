# Optimointi

## indeksi tietokantaan

- Tilanteissa joissaa käyttäjäolio haetaan tietokannasta id:n sijasta käyttäjän nimen perusteella, tietokanta joutuu käymään 
läpi koko users-taulun. Users-taulusta tapahtuvaa käyttäjätunnuksen perusteella tehtävää hakua voidaan nopeuttaa lisäämällä
taululle indeksi. Indeksi toimii hajautustaulun tavoin, eli tarjoaa "O(1)"-ajassa toimivan pääsyn haettuun tietokannan riviin.

- Luodaan indeksiä varten migraatio: rails g migration AddUserIndexBasedOnUsername

  - class AddUserIndexBasedOnUsername < ActiveRecord::Migration[5.2]
  - def change
  - add_index :users, :username

  - Suoritetaan migraatio komennolla rake db:migrate
  
 - Huonona puolena indeksöinnissä on poiston, ja lisäyksen yhteydessä indeksöinnin muokkaamiseen kukuva lisäaika
 
 ## Laiska lataaminen, n+1-ongelma ja tietokantakyselyjen optimointi
 
 - Optimoinnin avuksi kannattaa ladata Miniprofiler, jonka saa käyttöön lisäämällä gemfileen:gem 'rack-mini-profiler'
 
 - Sivuilla jotka näyttävät kaikki viinit, tehdään jokaista erillistä viiniä kohti oma kysely sekä styles- että wineyard tauluun.
- Syynä tälle on se, että activerecordissa on oletusarvoisesti käytössä ns. lazy loading, eli kun haemme olion tietokannasta, 
  olioon liittyvät kentät haetaan tietokannasta vasta jos niihin viitataan. Joskus tämä on toivottavaa, esim kun olioon liittyy
  suuri määrä olioita, joita ei välttämättä tarvita.   
- Ongelmaa kutsutaan n+1-ongelmaksi (ks. http://guides.rubyonrails.org/active_record_querying.html#eager-loading-associations)
  eli hakiessamme kannasta yhdellä kyselyllä listallisen olioita, jokainen listan olioista aiheuttaakin salakavalasti uuden
  tietokantahaun ja näin yhden haun sijaan tapahtuukin noin n+1 hakua.
  
  - Ratkaisuna voimme ohjata ActiveRecordin metodien parametrien avulla kyselyistä generoituvaa SQL:ää. Esim. seuraavasti  voimme ohjeistaa, että viinin lisäksi niihin liittyvät viinitilat ja tyylit tulee hakea tietokannasta kerralla:(eager loading)
      - def index
      - @beers = Beer.includes(:brewery, :style).all
      
## Cachays eli palvelinpuolen välimuistitoiminnallisuudet

- Datamäärän ollessa suuri, ei pelkkä kyselyjen optimointi riitä, vaan on etsittävä muita keieinoja kuten cachaus eli välimuistien käyttö.
- Jos cache on päällä, on projektissa olemassa tiedosto tmp/caching-dev.txt. Jos tiedostoa ei ole, saat cachen päälle suorittamalla komentoriviltä komennon rails dev:cache. Komennon pitäisi tulostaa: "Development mode is now being cached."
Jos komento tulostaa "Development mode is no longer being cached", suorita se uudelleen. Käynnistä nyt sovellus uudelleen.

- Cachays tapahtuu sisällyttämällä näkymätemplaten cachattavan osa, eli sivufragmentti seuraavanlaiseen lohkoon:
  - <% cache 'winelist', skip_digest: true do %>   ...   <% end %>  
- Nyt sivulla käytyämme sivun osa tallettuu välimuistiin ja seuraava sivun avaaminen on huomattavasti nopeampi.

- Ongelmia voi aihutua siinä että uusien viinien luominen tai poisto ei nyt näy sivulla..koska vanhat tiedot tulevat välimuistista.Syynä tälle on tietenkin se, että sivufragmentti löytyy edelleen välimuistista. Vanhentunut näkymäfragmentti tulisi siis ekspiroida. Tässä tapauksessa helpoin strategia on kontrollerista käsin tapahtuva manuaalinen ekspirointi.
komennolla expire_fragment(avain) joka laitetaan kontrollern kaikkiin kohtiin joissa listan sisältö mahd. muuttuu:create, update ja destroy. 
    - def create
    - expire_fragment('beerlist')
-Jos haluamme cachata yksittäisen oluen sivun, kannattaa fragmentin avaimeksi laittaa itse cachattava olio:
   - <% cache @wine do %> ......  <% end %>
-Ratkaisu on vielä sikäli puutteellinen, että jos olueeseen tehdään uusi reittaus, olio ei itsessään muutu ja fragmentti ei ekspiroidu. Ongelma on kuitenkin helppo korjata. Lisätään reittaukseen tieto, että reittauksen syntyessä, muuttuessa tai tuhoutuessa, on samalla 'kosketettava' reittaukseen liittyvää olutta:
  - class Rating < ApplicationRecord
  -  belongs_to :beer, touch: true
- Käytännössä belongs_to-yhteyteen liitetty touch: true saa aikaan sen, että yhteyden toisessa päässä olevan olion kenttä updated_at päivittyy.

## Eventual consistency
- Eventual consistencyllä elihieman löyhemmästä ajantasaisuusvaatimuksesta saatetaan pystyä tehostamaan sovelluksen suorituskykyä huomattavasti.Ajantasaisuus voi määritellä Railsissa laittamalla esim.fragmentticachelle expiroitumisaika:
  - <% cache 'fragment_name', expires_in:10.minutes do %>
  
- Toinen ja ehkä parempi tapa reittaussivun nopeuttamiselle olisi cachata Rails.cacheen kontrollerin tarvitsemat tiedot. 
- Yhtenä negatiivisena puolena cachen ajoittain tapahtuvassa ekspiroimisessa, esim. jos noudattaisimme strategiaa ratings-  sivun suhteen, aiheutuu jollekin käyttäjälle aika ajoin paljon aikaavievä operaatio siinä vaiheessa kun data on generoitava uudelleen välimuistiin.

## Asynkronisuus, viestijonot ja taustatyöt



