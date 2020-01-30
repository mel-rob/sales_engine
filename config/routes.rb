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
      namespace :customers do
        root 'customers#index'
        get 'find_all', to: 'find#index'
        get '/find', to: 'find#show'
        get '/random', to: 'random#show'
        get '/:id', to: 'customers#show'
        get '/:id/invoices', to: 'invoices#index'
        get '/:id/transactions', to: 'transactions#index'
      end
    end
  end
end
