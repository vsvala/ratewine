FactoryBot.define do
    factory :user do
      username { "Pekka" }
      password { "Foobar1" }
      password_confirmation { "Foobar1" }
      admin { true }
      close { false }
     
    end

    factory :wineyard do
        name { "anonymous" }
        year { 1900 } 
      end 

      factory :style do
        name { "Red" }
        description { 'kuvaus' } 
      end

      factory :wine do
        name { "anonymous" } 
        wineyard # viiniin liittyvä tila luodaan wineuard-tehtaalla
        style
      end
    
      factory :rating do
        wine # reittaukseen liittyvä viini luodaan viini-tehtaalla
      end
  end