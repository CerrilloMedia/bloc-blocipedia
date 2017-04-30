Rails.application.routes.draw do
  
  resources :wikis

  devise_for :users
  
  get 'show' => 'welcome#show'
  
  root 'welcome#index'
  
end
