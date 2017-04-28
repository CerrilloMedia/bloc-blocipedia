Rails.application.routes.draw do
  get 'welcome/show'
  
  root 'welcome#index'
end
