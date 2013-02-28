Rails.application.routes.draw do
  mount Flms::Engine => "/flms"
  root to: 'home#index'
end
