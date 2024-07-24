Rails.application.routes.draw do
  root "cover_letters#new"
  
  post '/generate_cover_letter', to: 'cover_letters#generate'
end
