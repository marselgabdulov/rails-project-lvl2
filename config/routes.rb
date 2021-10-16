Rails.application.routes.draw do
  devise_for :users

  root to: "posts#index"

  resources :posts do
    resources :post_comments
  end
end
