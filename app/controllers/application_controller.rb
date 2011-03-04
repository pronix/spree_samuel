class ApplicationController < ActionController::Base
  include Quickbooks
  protect_from_forgery
end
