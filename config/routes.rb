Rails.application.routes.draw do

devise_for :users, :controllers => {:registrations => "registrations"}

# this is so when we open our root page of the website, Rails knows which controller and its action to call
  root to: 'pages#index'

# this is shortening the path to /login
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
  end

# this is shortening the path to /signup
  devise_scope :user do
  get 'signup', to: 'devise/registrations#new'
end

end
