Rails.application.routes.draw do

  root to: 'sites#index'
  get 'search', to: 'search#index'
  resource :bookmark, only: [:new, :create]

  resources :sites, only: [:show, :index] do
    resources :bookmarks, only: [:index, :destroy, :edit, :update]
  end
end
