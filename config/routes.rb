Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    resources :indicators do
      resources :indicator_rules
      collection do
        get :roots
      end
      member do
        get :children
      end
    end
    resources :dictionaries do
      collection do
        get :roots
      end
      member do
        get :children
      end
    end
  end

  resource :dictionaries

  root 'application#index'

end
