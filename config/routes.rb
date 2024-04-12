Rails.application.routes.draw do
  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations',
        confirmations: 'users/confirmations',
        passwords: 'users/passwords'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :users, except: [:new, :create, :index, :destroy,:show], as: 'profile'
  resources :accounts, param: :account_id, except: :show do
    member do
      resources :charge_expenses, except: :show
      resources :income_expenses, except: :show
      resources :bank_accounts, except: :show
      resources :partners, except: :show
      resources :bank_statements, except: :show
      # resources :invoices, except: :show
      resources :supplier_invoices, except: :show
      resources :sales_invoices, except: :show
      resources :main_books
    end
  end
  # Defines the root path route ("/")

   root "accounts#index"
end
