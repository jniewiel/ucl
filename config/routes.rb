Rails.application.routes.draw do
  # Root path
  root 'home#index'
  
  # Devise routes
  devise_for :users

  # Home controller routes
  get 'home', to: 'home#index'
  get 'guest_login', to: 'home#guest_login'
  get 'ucl_test', to: 'home#test'
  get 'contact_us', to: 'home#contact-form'

  # reusable routing concern
  concern :selectable do
    get 'select', on: :collection
  end

  # Resume & Job Posting routes
  resources :resumes, concerns: :selectable
  resources :job_postings, concerns: :selectable do
    post 'fetch_id', on: :collection
  end
  
  # Cover Letter routes
  resources :cover_letters, only: [:index, :show, :new, :edit, :update, :destroy], concerns: :selectable do
    post 'generate', on: :collection
    post 'save', on: :collection
  end

  get 'ucl_new', to: 'cover_letters#new'
end
