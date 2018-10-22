# Optimointi

## indeksi tietokantaan

- Tilanteissa joissaa käyttäjäolio haetaan tietokannasta id:n sijasta käyttäjän nimen perusteella, ietokanta joutuu käymään 
läpi koko users-taulun. Users-taulusta tapahtuvaa käyttäjätunnuksen perusteella tehtävää hakua voidaan nopeuttaa lisäämällä
taululle indeksi. Indeksi toimii hajautustaulun tavoin, eli tarjoaa "O(1)"-ajassa toimivan pääsyn haettuun tietokannan riviin.

-Luodaan indeksiä varten migraatio: rails g migration AddUserIndexBasedOnUsername

  - class AddUserIndexBasedOnUsername < ActiveRecord::Migration[5.2]
  - def change
  - add_index :users, :username

  -Suoritetaan migraatio komennolla rake db:migrate
  
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
  
  -Ratkaisuna voimme ohjata ActiveRecordin metodien parametrien avulla kyselyistä generoituvaa SQL:ää. Esim. seuraavasti voimme ohjeistaa, 
   että viinin lisäksi niihin liittyvät viinitilat ja tyylit tulee hakea tietokannasta kerralla:(eager loading)
      - def index
      - @beers = Beer.includes(:brewery, :style).all
      
## Cachays eli palvelinpuolen välimuistitoiminnallisuudet
