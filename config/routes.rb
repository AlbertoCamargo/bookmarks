Rails.application.routes.draw do

  root to: 'sites#index'
  get 'search', to: 'search#index'

  resource :bookmark, only: [:new, :create]
  resources :bookmarks, only: :index
  resources :sites, only: [:show, :index] do
    resources :bookmarks, only: [:destroy, :edit, :update]
  end
end
