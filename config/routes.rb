Rails.application.routes.draw do
  namespace :v1 do
    resources :customers, except: [:new, :edit]
    resources :orders, except: [:new, :edit]
  end
end
