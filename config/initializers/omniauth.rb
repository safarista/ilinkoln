Rails.application.config.middleware.use OmniAuth::Builder do
  TWITTER_KEY    = 'yoOvJm6MuxeBbIvJaa1mOYPsBGOgvyyj0hXc5PAoE'
  TWITTER_SECRET = 'cHlDBmjtfZxLx5bEYnYg'
  provider :twitter, ENV[TWITTER_KEY], ENV[TWITTER_SECRET]
  
end
