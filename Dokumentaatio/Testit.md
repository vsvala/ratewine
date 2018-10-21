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
