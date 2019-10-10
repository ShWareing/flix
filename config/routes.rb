Rails.application.routes.draw do
  
  resources :genres
  resource :session

  resources :users
  # resources :reviews
  root "movies#index"
  resources :movies do
    resources :reviews
    resources :favorites
  end

  root "users#index"
  get "signup" => "new"

end
