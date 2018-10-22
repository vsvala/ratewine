# Heroku yhteydet

- Sovelluksen deployaaminen Herokuun onnistuu helpoiten jos sovelluksen hakemisto on oma git-repositorionsa.

- luo Herokuun tunnus.
- luo ssh-avain ja lisää se herokuun sivulla https://dashboard.heroku.com/account
- ohje ssh-avaimen luomiseen https://github.com/mluukkai/otm-2018/blob/master/tehtavat/viikko1.md#julkinen-avain
- Asenna komentoriviliittymän sisältävä Heroku Toolbelt sivun https://toolbelt.heroku.com/ ohjeiden mukaan.

- Asennettuasi komentorivikäyttöliittymän mene sovelluksen juurihakemistoon, ja luo sovellusta varten heroku-instanssi komennolla: heroku create
- Syötä pyydettäessä Heroku-tunnuksesi.
-  Sovelluksen URLin alkuosan saa haluamaansa muotoon antamalla komennon muodossa heroku create urlin_alkuosa.
- Railsissa sovellukset käyttävät oletusarvoisesti sqlite-tietokantaa, mutta Herokussa käytössä on PostgreSQL-tietokanta. otta saamme PostgreSQLn käyttöön, joudumme tekemään muutoksen Gemfileen.

- Poista rivi: gem 'sqlite3' ja lisää johonkin kohtaa tiedostoa allaolevat ja sen suorita komentorivillä: bundle install

  - group :development, :test do
    - gem 'sqlite3'
  - end

  - group :production do
    - gem 'pg'
    - gem 'rails_12factor'
  - end

- Sovellus käynnistetään suorittamalla komentoriviltä operaatio: git push heroku master
- Migraatiot onnistuu komennolla: heroku run rails db:migrate, jatkossakin on aina muistettava suorittaa migraatiot deployatessamme sovellusta Herokuun.
- Jos haluat seed.rb tiedostossa määritellyt oliot tietokantaan, voit antaa komennon: heroku run rails db:seed
- Jatkossakin on siis aina muistettava suorittaa migraatiot deployatessamme sovellusta Herokuun.

- Voimme myös avata Rails-konsolin Herokussa sijaitsevalle sovellukselle komennolla: heroku run console


## Ongelmia herokuun deployaamisessa

- Sovellusta deplyatessa tuotantoon syntyy usein ongelmia ja virheilmoituksia.  Tuotantomoodissa virheiden syy täytyykin kaivaa
sovelluksen lokista jonka saa herokussa esille:

  - heroku logs 
  - Heroku logs --tail

- Jos olet esim. lisännyt sovellukseen uusia tietokantatauluja, muista suorittaa migraatiot myös herokussa
    - heroku run rails db:migrate
    
-Useimmiten tuotannossa vastaan tulevat ongelmat johtuvat myös siitä, että tietokantaskeeman muutosten takia jotkut oliot ovat joutuneet epäkonsistenttiin tilaan, eli ne esim. viittaavat olioihin joita ei ole tai viitteet puuttuvat, 
undefined method `name' for nil:NilClass. Korjaantuu esim poistamalla:

  - heroku run console,  heroku konsolin käynnistys
  - >bad_wine =  Wine.all.select{ |b| b.wineyrd.nil? }
  - >bad_wine.each{ |bad| bad.delete }
  - >Wine.all.select{ |b| b.wineyard.nil? }
=> []
  - onnistuu myös seuraavalla: wine.all.select{ |r| r.wineyard.nil? }.each{ |r| r.delete }
  
-Tai jos esim. raittauksiin ei ole liitetty useria..-->Luodaan järjestelmään käyttäjä ja laitetaan herokun konsolista kaikkien olemassaolevien reittausten käyttäjäksi järjestelmään ensimmäisenä luotu käyttäjä:

> u = User.first
> Rating.all.each{ |r| u.ratings << r }
