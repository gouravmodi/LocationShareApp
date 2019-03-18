Rails.application.routes.draw do
  root 'users#index'
  devise_for :users

  resources :users, only: [:show, :index] do
    get :locations, on: :member
  end
  resources :locations do
    get :public_locations, on: :collection
  end

  get '/:username' => 'users#show'
end
