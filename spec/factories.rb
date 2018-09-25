FactoryBot.define do
    factory :user do
      username { "Pekka" }
      password { "Foobar1" }
      password_confirmation { "Foobar1" }
    end

    factory :wineyard do
        name { "anonymous" }
        year { 1900 } 
      end
    
      factory :wine do
        name { "anonymous" }
        style { "Red" } 
        wineyard # viiniin liittyvä tila luodaan wineuard-tehtaalla
      end
    
      factory :rating do
        wine # reittaukseen liittyvä viini luodaan viini-tehtaalla
      end
  end