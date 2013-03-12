Flms::Engine.routes.draw do

  resources :pages do
    put 'blocks', to: 'blocks#update_all'
    resources :blocks do
      resources :layers, except: [:index]
    end
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
