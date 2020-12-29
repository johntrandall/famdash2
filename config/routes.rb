Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get 'home/index'
  root to: "home#index"

  resource :current_user, only: :update
  resource :selected_user, only: :update
  resources :happenings, only: [:index, :create]
  resources :happening_templates, only: [:index, :update] do
    member do
      patch :sort_higher
      patch :sort_down
    end
  end
end
