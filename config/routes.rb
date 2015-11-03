Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :customers, except: [:new, :edit] do
        collection do
          get "find"
          get "find_all"
        end
      end

      resources :invoice_items, except: [:new, :edit] do
        collection do
          get "find"
          get "find_all"
        end
      end

      resources :invoices, except: [:new, :edit] do
        collection do
          get "find"
          get "find_all"
        end
      end

      resources :items, except: [:new, :edit] do
        collection do
          get "find"
          get "find_all"
        end
      end

      resources :merchants, except: [:new, :edit] do
        collection do
          get "find"
          get "find_all"
        end
      end

      resources :transactions, except: [:new, :edit] do
        collection do
          get "find"
          get "find_all"
        end
      end
    end
  end
end
