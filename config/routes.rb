Rails.application.routes.draw do
  devise_for :users
  
  root "home#index"

  resources :job_postings
  resources :cover_letters
  resources :resumes

  get 'guest_login', to: 'home#guest_login'
  get 'ucl_test', to: 'home#test'
  get 'ucl_new', to: 'cover_letters#new'

  get 'user_resumes', to: 'resumes#select'
  get 'user_job_postings', to: 'job_postings#select'  

  post 'generate_cover_letter', to: 'cover_letters#generate'
end
