### Sessiot ja Kirjautuminen

- Evästeiden toimintaperiaate on seuraava: kun selaimella mennään jollekin sivustolle, voi palvelin lähettää vastauksessa 
selaimelle pyynnön evästeen tallettamisesta. Jatkossa selain liittää evästeen kaikkiin sivustolle kohdistuneisiin 
HTTP-pyyntöihin. Eväste on käytännössä pieni määrä dataa, ja palvelin voi käyttää evästeessä olevaa dataa haluamallaan tavalla 
evästeen omaavan selaimen tunnistamiseen.

- Railsissa sovelluskehittäjän ei ole tarvetta työskennellä suoraan evästeiden kanssa, sillä Railsiin on toteutettu evästeiden 
avulla hieman korkeammalla abstraktiotasolla toimivat sessiot ks. http://guides.rubyonrails.org/action_controller_overview.html#session 
joiden avulla sovellus voi "muistaa" tiettyyn selaimeen liittyviä asioita, esim. käyttäjän identiteetin, useiden HTTP-pyyntöjen
ajan.

- Rails-sovelluksen koodissa HTTP-pyynnön tehneen käyttäjän (tai tarkemmin ottaen selaimen) sessioon pääsee käsiksi hashin 
kaltaisesti toimivan olion session kautta.
