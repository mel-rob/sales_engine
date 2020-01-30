Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        root 'merchants#index'
        get '/most_revenue', to: 'revenue#index'
        get '/find_all', to: 'find#index'
        get '/find', to: 'find#show'
        get '/random', to: 'random#show'
        get '/:id', to: 'merchants#show'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
      end
      # resources :merchants, only: [:index, :show] do
      #   resources :items, only: [:index]
      #   resources :invoices, only: [:index]
      # end
    end
  end
end
