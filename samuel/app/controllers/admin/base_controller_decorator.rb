Admin::BaseController.class_eval do
  layout :detect_layout

  def detect_layout
    (current_user && current_user.has_role?(:seller)) ? "seller" : "admin"
  end
end


