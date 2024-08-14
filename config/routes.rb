Rails.application.routes.draw do
  devise_for :users
  
  root 'home#index'

  resources :resumes
  resources :job_postings
  resources :cover_letters, only: [:index, :show, :new, :edit, :update, :destroy]

  get 'home', to: 'home#index'

  get 'guest_login', to: 'home#guest_login'
  get 'ucl_test', to: 'home#test'
  get 'ucl_new', to: 'cover_letters#new'

  get 'user_resumes', to: 'resumes#select'
  
  get 'user_job_postings', to: 'job_postings#select'

  get 'user_cover_letters', to: 'cover_letters#select'
  post 'generate_cover_letter', to: 'cover_letters#generate'

  post 'fetch_job_posting_id', to: 'job_postings#fetch_job_posting_id'

  post 'save_cover_letter', to: 'cover_letters#save'

end
