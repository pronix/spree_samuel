Admin::OverviewController.class_eval do

  private
  def authorize_admin
    current_user.try(:seller_and_not_admin?) ? authorize!(:seller, self.class) : authorize!( :admin, Object)
  end

  def show_dashboard
    orders_current_user.count > Spree::Config.instance.preferences["count_show_dashboard"].to_i
  end

  # Заказы текущего пользователя
  #
  def orders_current_user
    (current_user.try(:seller_and_not_admin?) ?  current_user.seller_orders : Order)
  end

  def conditions(params)
    if params.key? :to
      ["orders.completed_at >= ? AND orders.completed_at <= ?", params[:from], params[:to]]
    else
      ["orders.completed_at >= ?", params[:from]]
    end
  end


  # Методы из spree-dash
  #
  def orders_by_day(params)

    if params[:value] == "Count"
      orders = orders_current_user.select(:"orders.created_at").where(conditions(params))
      orders = orders.group_by { |o| o.created_at.to_date }
      fill_empty_entries(orders, params)
      orders.keys.sort.map {|key| [key.strftime('%Y-%m-%d'), orders[key].size ]}
    else
      orders = orders_current_user.select([:"orders.created_at", :"orders.total"]).where(conditions(params))
      orders = orders.group_by { |o| o.created_at.to_date }
      fill_empty_entries(orders, params)
      orders.keys.sort.map {|key| [key.strftime('%Y-%m-%d'), orders[key].inject(0){|s,o| s += o.total} ]}
    end
  end

  def orders_line_total(params)
    orders_current_user.sum(:item_total, :conditions => conditions(params))
  end

  def orders_total(params)
    orders_current_user.sum(:total, :conditions => conditions(params))
  end

  def orders_credit_total(params)
    orders_current_user.sum(:credit_total, :conditions => conditions(params))
  end

  def line_items_sum_options(options={ :group => :variant_id, :limit => 5})
    if current_user.try(:seller_and_not_admin?)
      options.merge!({ :conditions => {:"products.seller_id" => current_user.id },
                       :joins => [:variant => :product] })
    end
    options
  end

  def best_selling_variants
    li = LineItem.sum(:quantity, line_items_sum_options)
    variants = li.map do |v|
      variant = Variant.find(v[0])
      [variant.name, v[1] ]
    end
    variants.sort { |x,y| y[1] <=> x[1] }
  end

  def top_grossing_variants
    quantity = LineItem.sum(:quantity, line_items_sum_options)
    prices   = LineItem.sum(:price, line_items_sum_options)
    variants = quantity.map do |v|
      variant = Variant.find(v[0])
      [variant.name, v[1] * prices[v[0]]]
    end

    variants.sort { |x,y| y[1] <=> x[1] }
  end

  def last_five_orders
    orders =  orders_current_user.where("orders.completed_at IS NOT NULL").order("orders.completed_at DESC").limit(5)
    orders.map do |o|
      qty = o.line_items.inject(0) {|sum,li| sum + li.quantity}
      [o.email, qty, o.total]
    end
  end

  def biggest_spenders
    spenders = orders_current_user.sum(:total, :group => :user_id, :limit => 5, :order => "sum(total) desc", :conditions => "orders.completed_at is not null and order.user_id is not null")
    spenders = spenders.map do |o|
      orders = User.find(o[0]).orders
      qty = orders.size

      [orders.first.email, qty, o[1]]

    end

    spenders.sort { |x,y| y[2] <=> x[2] }
  end

  def out_of_stock_products
    (
     current_user.try(:seller_and_not_admin?) ? current_user.products : Product
     ).where(:count_on_hand => 0).limit(5)
  end




end
