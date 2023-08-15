Rails.application.routes.draw do
  resources :settings
  resources :barangay_calls
  devise_for :users
  resources :barangays
  resources :chats
  
  get 'login/index'
  get 'barangay_calls/make_call'
  root 'dashboard#index'
  post 'send_sms', to: 'controller_name#send_sms'

  devise_scope :user do
    get 'users/sign_out' => 'devise/sessions#destroy'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
