Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :twitter, ENV['cHlDBmjtfZxLx5bEYnYg'], ENV['yoOvJm6MuxeBbIvJaa1mOYPsBGOgvyyj0hXc5PAoE']
  
end