Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, only: [:index, :show, :destroy]
  resources :items
  resources :categories
  resources :brands
  get 'history', to: 'items#history'
  post 'reallocate', to: 'items#reallocate'
  get 'deallocate', to: 'items#deallocate'
end
