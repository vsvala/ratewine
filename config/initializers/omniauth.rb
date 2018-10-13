Rails.application.config.middleware.use OmniAuth::Builder do
    provider :github, ENV[0de1c127e7f30991f7ad], ENV[ad703920061eacd9e07b0a0d61ee760ac73a6b3a]
   end