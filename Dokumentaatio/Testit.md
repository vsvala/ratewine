# Testit

- sovelluksen testaamiseen on käytetty [Rspec:iä](http://rspec.info/),[lisää](https://github.com/rspec/rspec-rails)
- Rsepc-railsin gem saa käyttöön lisäämällä Gemfileen seuraava ja suorittamalla komentoriviltä bundle install :
  - group :development, :test do
  - gem 'rspec-rails', '~> 3.8'
  - end
- Tämän jälkeen rspec saadaan initialisoitua sovelluksen käyttöön antamalla komentoriviltä komento: rails generate rspec:install
