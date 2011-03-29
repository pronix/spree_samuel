Rails.application.routes.draw do
  resource :invoice , :controller => :order
end
