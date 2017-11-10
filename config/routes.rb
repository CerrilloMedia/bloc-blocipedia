Rails.application.routes.draw do
  
  resources :charges, only: [:new, :create, :destroy]
  
  resources :wikis do
    resources :collaborations, only: [:create, :destroy]
    # post 'create' => 'collaborations/create'
  end

  devise_for :users
  
  get 'show' => 'welcome#show'
  
  root 'welcome#index'
  
end