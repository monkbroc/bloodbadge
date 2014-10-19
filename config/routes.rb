Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :sessions      => "custom_sessions"
  }
  resource :profile, :only => [:show], :controller => 'profile'

  resources :badges, :param => :key, :only => [:show]
  root :to => "home#index"
end
