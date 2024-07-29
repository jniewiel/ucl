Rails.application.routes.draw do
  devise_for :users
  
  root "cover_letters#new"
  
  resources :job_postings
  resources :cover_letters
  resources :resumes

  post '/generate_cover_letter', to: 'cover_letters#generate'
end
