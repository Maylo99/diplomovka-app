Rails.application.routes.draw do
  resources :articles
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }

  # Ensure you have overridden routes for generated controllers in your routes.rb.
  #   For example:
  #
  # Rails.application.routes.draw do
  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  #   }
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "artciles#index"
end
