Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "customers/find" => "customers#find", defaults: { format: :json }
      resources :customers, except: [:new, :edit], defaults: { format: :json }
      get "invoice_items/find" => "invoice_items#find", defaults: { format: :json }
      resources :invoice_items, except: [:new, :edit], defaults: { format: :json }
      get "invoices/find" => "invoices#find", defaults: { format: :json }
      resources :invoices, except: [:new, :edit], defaults: { format: :json }
      get "items/find" => "items#find", defaults: { format: :json }
      resources :items, except: [:new, :edit], defaults: { format: :json }
      get "merchants/find" => "merchants#find", defaults: { format: :json }
      resources :merchants, except: [:new, :edit], defaults: { format: :json }
      get "transactions/find" => "transactions#find", defaults: { format: :json }
      resources :transactions, except: [:new, :edit], defaults: { format: :json }
    end
  end
end
