Rails.application.routes.draw do
  namespace :admin do
    scope "/authorize_net_reports" do
      resources :transactions
    end
  end
end
