Rails.application.routes.draw do
  devise_for :users
  root "cover_letters#new"
  
  post '/generate_cover_letter', to: 'cover_letters#generate'
end
