# Autentikointi

- [HTTP Basic -autentikaatio](https://api.rubyonrails.org/classes/ActionController/HttpAuthentication/Basic.html) on kätevä 
tapa yksinkertaisiin sivujen suojaamistarpeisiin, mutta monimutkaisemmissa tilanteissa ja parempaa tietoturvaa edellytettäessä 
kannattaa käyttää muita ratkaisuja.

-Kannattaa huomata, että HTTP Basic -autentikaatiota ei tule käyttää kuin suojatun HTTPS-protokollan yli sillä käyttäjätunnus 
ja salasana lähtetään Base64-enkoodattuna, eli käytännössä kuka tahansa voi headereihin käsiksi päästyään selvittää salasanan. 
Hieman parempi on [Digest-autentikaatio](http://api.rubyonrails.org/classes/ActionController/HttpAuthentication/Digest.html)
jossa käyttäjätunnuksen ja salasanan sijaan tunnistautuminen tapahtuu yksisuuntaisella funktiolla laskettavan tunnisteen avulla.

