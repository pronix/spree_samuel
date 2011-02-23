Rails.application.routes.draw do
  namespace :admin do
    resources :reports, :only => [:index, :show] do
      scope :via => [:get, :post] do
        collection  do
          match "advanced_sales"
          match "sales_total"
          match "revenue"
          match "count"
          match "units"
          match "profit"
          match "top_customers"
          match "top_products"
          match "geo_revenue"
          match "geo_units"
          match "geo_profit"
        end
      end
    end
    resources :advanced_sales, :only => [] do
      scope  :via => [:get, :post] do
        member do
          match "users"
          match "vendors"
          match "products"
          match "taxons"
          match "payment_methods"
          match "coupons"
        end
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
