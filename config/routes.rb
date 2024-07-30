Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"

  resources :job_postings
  resources :cover_letters
  resources :resumes

  get 'guest_login', to: 'home#guest_login'
  get 'ucl_test', to: 'home#test'

  post 'generate_cover_letter', to: 'cover_letters#generate'
end
