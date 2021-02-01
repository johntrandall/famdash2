Rails.application.routes.draw do
  get 'home/index'
  root to: "home#index"

  resource :current_user, only: :update
  resource :selected_user, only: :update
  resources :happenings, only: [:index, :create, :edit, :update] do
    collection do
      get :grid_index
    end
  end
  resources :happening_templates, only: [:index, :show, :create, :update] do
    member do
      patch :sort_higher
      patch :sort_down
    end
  end
end
