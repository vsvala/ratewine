# Heroku yhteydet
siirto herokuun...

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
