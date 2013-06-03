Flms::Engine.routes.draw do

  resources :blocks do
    resources :layers, only: [:destroy]
    resources :image_layers, except: [:index, :show, :destroy]
    resources :text_layers, except: [:index, :show, :destroy]
    resources :paragraph_layers, except: [:index, :show, :destroy]
    resources :embed_layers, except: [:index, :show, :destroy]
    resources :animation_layers, except: [:index, :show, :destroy]
  end

  resources :pages do
    put 'add_block'
    delete 'remove_block'
    put 'edit', to: 'pages#update_blocks'
  end

  devise_for :user,
             class_name: 'Flms::User',
             module: :devise,
             controllers: { sessions: 'flms/sessions',
                            passwords: 'flms/passwords' },
             path_names: { sign_out: 'logout' }

  devise_scope :user do
    get '/login', to: 'sessions#new', as: :login
    post '/login', to: 'sessions#create'
    get '/logout', to: 'sessions#destroy', as: :logout
  end

  resources :users, only: [:index, :new, :create, :destroy]

  root :to => 'dashboard#index'

end
