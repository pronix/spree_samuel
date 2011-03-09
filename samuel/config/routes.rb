Rails.application.routes.draw do
  # Add your extension routes here
  scope "/account/:address_type", :constraints => {:address_type => /bill|ship/}  do
    resource :addresses, :only => [:show, :edit, :update]
  end

  namespace :admin do
    match '/inventory' => 'inventory#index',  :as => 'inventory', :via => :get
    match '/inventory' => 'inventory#update', :as => 'inventory', :via => :put
    match '/track-accounts' => 'track_accounts#index',  :as => 'track_accounts', :via => :get
  end
  match "/quickbooks/gateway" => "quickbooks#gateway", :as => 'quickbooks_gateway', :via => :post  
end
