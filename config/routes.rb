Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
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
