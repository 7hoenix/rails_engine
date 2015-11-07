Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :customers, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        member do
          get "invoices"
          get "transactions"
          get "favorite_merchant"
        end
      end

      resources :invoice_items, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        member do
          get "invoice"
          get "item"
        end
      end

      resources :invoices, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        member do
          get "transactions"
          get "invoice_items"
          get "items"
          get "customer"
          get "merchant"
        end
      end

      resources :items, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
          get "most_revenue"
          get "most_items"
        end
        member do
          get "invoice_items"
          get "merchant"
          get "best_day"
        end
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], module: "merchants"
        resources :invoices, only: [:index], module: "merchants"
        collection do
          get "find"
          get "find_all"
          get "random"
          get "most_revenue"
          get "most_items"
          get "revenue", to: "merchants#total_revenue"
        end
        member do
          get "revenue"
          get "favorite_customer"
          get "customers_with_pending_invoices"
        end
      end

      resources :transactions, only: [:index, :show] do
        collection do
          get "find"
          get "find_all"
          get "random"
        end
        member do
          get "invoice"
        end
      end
    end
  end
end
