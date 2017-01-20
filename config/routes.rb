Rails.application.routes.draw do
  root 'welcome#index'
  resources :brands, except: [:show, :destroy]
  resources :categories, except: [:show]

  resources :checkouts, except: [:destroy] do
    member do
      get 'checkin'
    end
  end

  resources :documents, only: [:destroy]
  resources :employees

  resources :issues, except: [:destroy] do
    member do
      put 'set_resolution'
      get 'close'
      put 'close_issue'
      put 'set_priority'
    end
  end

  resources :items do
    member do
      get 'allocate'
      put 'reallocate'
      get 'discard_reason'
      put 'discard'
      put 'remove_item'
      get 'addparent'
      put 'change_parent'
      get 'item_render'
      get 'parent_render'
      get 'addchild'
      put 'change_child'
    end
  end

  resources :systems, except: [:destroy]
  resources :resolutions, except: [:show, :destroy]
  resources :users, except: [:show]
  resources :vendors, except: [:destroy]
  get "/login", to: redirect("/auth/google_oauth2")
  get "/auth/google_oauth2/callback", to: "sessions#create"
  delete 'logout', to: 'sessions#destroy'
end
