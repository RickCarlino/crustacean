Srs::Application.routes.draw do
  resources :topics, only: [:index, :destroy, :show] do
    resources :reviews, only: [:create, :destroy, :show, :index]
  end
end
