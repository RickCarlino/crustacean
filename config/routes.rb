Srs::Application.routes.draw do
  resources :topics, only: [:index] do
    resources :reviews, only: [:index]
  end
end
