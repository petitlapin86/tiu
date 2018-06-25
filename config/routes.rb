Rails.application.routes.draw do

  devise_for :users
  root to: 'pages#index'
  # this is so when we open our root page of the website, Rails knows which controller and its action to call
end
