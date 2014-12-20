Haystack::Engine.routes.draw do
  resources :searches, :only => [:new, :create]
end
