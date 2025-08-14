Rails.application.routes.draw do
  root 'static_pages#top'
  get "up" => "rails/health#show", as: :rails_health_check
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get    'signup', to: 'users#new'
  post   'signup', to: 'users#create'
  resources :users, only: %i[new create]
  resources :reports do
    resources :emails, only: [:new, :create], module: :reports
  end
end
