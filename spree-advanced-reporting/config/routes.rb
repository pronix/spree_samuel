Rails.application.routes.draw do
  namespace :admin do
    resources :reports, :only => [:index, :show] do
      collection do
        get :sales_total
        get :revenue
        get :count
        get :units
        get :profit
        get :top_customers
        get :top_products
        get :geo_revenue
        get :geo_units
        get :geo_profit
      end
    end
  end

  match '/admin/reports/revenue' => 'admin/reports#revenue', :via => [:get, :post]
  match '/admin/reports/count' => 'admin/reports#count', :via => [:get, :post]
  match '/admin/reports/units' => 'admin/reports#units', :via => [:get, :post]
  match '/admin/reports/profit' => 'admin/reports#profit', :via => [:get, :post]
  match '/admin/reports/top_customers' => 'admin/reports#top_customers', :via => [:get, :post]
  match '/admin/reports/top_products' => 'admin/reports#top_products', :via => [:get, :post]
  match '/admin/reports/geo_revenue' => 'admin/reports#geo_revenue', :via => [:get, :post]
  match '/admin/reports/geo_units' => 'admin/reports#geo_units', :via => [:get, :post]
  match '/admin/reports/geo_profit' => 'admin/reports#geo_profit', :via => [:get, :post]
  # match "/admin" => "admin/advanced_report_overview#index", :as => :admin
end
