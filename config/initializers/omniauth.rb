Rails.application.config.middleware.use OmniAuth::Builder do
    # provider :github, ENV['d1123727b49b9139e48e'], ENV['f3f0cf28e5d75a73ab3b2b22bcf1069b9411c4c5']
    provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET'] 
end
