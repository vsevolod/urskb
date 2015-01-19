Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    resources :dictionaries
  end

  resource :dictionaries

  root 'application#index'

end
