# Перезагрузка параметров spree по умолчанию
#
AppConfiguration.class_eval do
  preference :site_name,            :string,  :default => ''
  preference :site_url,             :string,  :default => ''
  # preference :admin_interface_logo, :string,  :default => "/images/logo.png"
  # preference :logo,                 :string,  :default => '/images/logo.png'
  # preference :products_per_page,    :integer, :default => 24
  preference :mails_from,           :string,  :default => "no-reply@spree.com"
  preference :count_show_dashboard, :integer,  :default => 10 # мин. кол-во заказов для вывода статистики в admin/dashboard
end
