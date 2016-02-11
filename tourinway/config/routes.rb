# Rails.application.routes.draw do
#   resources :maps
#   devise_for :users
#   root to: "top#index"
#   resources :users, only: [:show, :edit, :update]
#   resources :products, only: [:new, :create, :show, :edit, :destroy, :update] do
#     collection do
#       get 'search'
#     end
#   end
#   resources :reviews, only: [:create, :destroy]
# end

Rails.application.routes.draw do
  resources :maps
  devise_for :users
  root to: "top#index"
  resources :users, only: [:show, :edit, :update]
  resources :products, only: [:new, :create, :show, :edit, :destroy, :update] do
    collection do
      get 'search'
    end
    resources :reviews, only: [:create, :destroy]
  end
end
