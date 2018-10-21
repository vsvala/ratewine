# Testit

- sovelluksen testaamiseen on käytetty [Rspec:iä](http://rspec.info/),[lisää](https://github.com/rspec/rspec-rails)
- Rsepc-railsin gem saa käyttöön lisäämällä Gemfileen seuraava ja suorittamalla komentoriviltä bundle install :
  - group :development, :test do
  - gem 'rspec-rails', '~> 3.8'
  - end
- Tämän jälkeen rspec saadaan initialisoitua sovelluksen käyttöön antamalla komentoriviltä komento: rails generate rspec:install

-Yksikkötestit

  - Testipohjan voi luoda käsin tai komentoriviltä rspec-generaattorilla:  rails generate rspec:model user
  - Tämä luo hakemistoon /spec/models tiedoston user_spec.rb

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    expect(user.username).to eq("Pekka")
  end
end

- Testi kirjoitetaan it-nimiselle metodille annettavan koodilohkon sisälle. Metodin ensimmäisenä parametrina on merkkijono, joka toimii testin nimenä. Muuten testi kirjoitetaan samaan tapan kuin esim. jUnitilla, eli ensin luodaan testattava data, sitten suoritetaan testattava toimenpide ja lopuksi varmistetaan että vastaus on odotettu.

- Testin alustus (eli testattavan olion luomisen) kannattaa tehdä tekemällä samanlaisen alustuksen omaavalle osalle testeistä oma describe-lohko, jonka alkuun määritellään ennen jokaista testiä suoritettava let-komento, joka alustaa user-muuttujan uudelleen jokaista testiä ennen.

### Testimuuttujien alustus

- Muuttujien alustus tapahtuu hieman erikoisen let-metodin avulla, esim. let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }
saa aikaan sen, että määrittelyn jälkeen muuttuja user viittaa let-metodin koodilohkossa luotuun User-olioon.


- Toinen parempi tapa voi olla koota testiympäristön rakentaminen, eli testien alustamiseen tarvittava data omaan paikkaansa, "testifixtureen". Käytämme testien alustamiseen Railsin oletusarvoisen fixture-mekanismin sijaan FactoryBot-nimistä gemiä, kts. https://github.com/thoughtbot/factory_bot ja https://github.com/thoughtbot/factory_bot_rails

Lisätään Gemfileen seuraava

group :test do
  gem 'factory_bot_rails'
end
ja päivitetään gemit komennolla bundle install

Tehdään fixtureja varten tiedosto spec/factories.rb ja kirjoitetaan sinne seuraava:

FactoryBot.define do
  factory :user do
    username { "Pekka" }
    password { "Foobar1" }
    password_confirmation { "Foobar1" }
  end
end

Määriteltyjä tehtaita voidaan pyytää luomaan olioita seuraavasti:

user = FactoryBot.create(:user)

- Lisää ohjeita FactoryBotin käyttöön osoitteessa https://www.rubydoc.info/gems/factory_bot/file/GETTING_STARTED.md
