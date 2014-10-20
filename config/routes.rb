Srs::Application.routes.draw do
  resources :topics, only: [:index, :create] do
    resources :reviews, only: [:index, :update, :create]
    resources :facts, only: [:create]
  end
  resources :users, only: :create
end
