Rails.application.routes.draw do
  # Add your extension routes here
  namespace :admin do
    match '/inventory' => 'inventory#index',  :as => 'inventory', :via => :get
    match '/inventory' => 'inventory#update', :as => 'inventory', :via => :put
  end
end
