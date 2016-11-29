Rails.application.routes.draw do
  root 'welcome#index'
  resources :users, except: [:show]
  resources :items do
    member do
      get 'allocate'
      put 'reallocate'
    end
  end
  resources :item_histories, except: [:destroy, :edit, :update]
  resources :categories
  resources :brands
  resources :employees
  resources :systems, except: [:destroy]
  resources :checkouts, except: [:destroy] do
    member do
      get 'checkin'
    end
  end
  resources :issues do
    member do
      put 'set_resolution'
      get 'close'
      put 'close_issue'
      put 'set_priority'
    end
  end
  resources :vendors
  resources :resolutions, except: [:show, :destroy]
  get 'history', to: 'items#history'
  post 'reallocate', to: 'items#reallocate'
  get 'deallocate', to: 'items#deallocate'
  get "/login", to: redirect("/auth/google_oauth2")
  get "/auth/google_oauth2/callback", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'
  get 'systems/:id/history', to: 'systems#history', as: 'system_history'

end
