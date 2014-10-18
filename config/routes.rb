Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions      => "custom_sessions"
  }
  resources :profile, :param => :key, :only => [:show]
  root :to => "home#index"
end
