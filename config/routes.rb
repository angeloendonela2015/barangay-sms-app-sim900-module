Rails.application.routes.draw do
  get 'login/index'
  devise_for :users
  resources :barangays
  resources :chats
  root 'dashboard#index'

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
