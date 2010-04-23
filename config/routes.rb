DeclAuthDemoApp::Application.routes.draw do

  resources :conferences do
    resources :talks do
      resources :talk_attendees#, :as => :attendees
    end
    resources :conference_attendees#, :as => :attendees
  end

  match '/logout', :to => "sessions#destroy", :as => "logout"
  match '/login', :to => "sessions#new", :as => "login"
  match '/register', :to => 'users#create', :as => "register"
  match '/signup', :to => 'users#new', :as => "signup"

  resources :users
  resource :session
  
  root :to => "conferences#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
