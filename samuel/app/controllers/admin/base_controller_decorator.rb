Admin::BaseController.class_eval do
  layout :detect_layout

  def detect_layout
    (current_user &&
     current_user.has_role?(:seller) && !current_user.has_role?(:admin)) ? "seller" : "admin"
  end


  # Заказы текущего пользователя
  #
  def orders_current_user
    (current_user.try(:seller_and_not_admin?) ?  current_user.seller_orders : Order)
  end

end


