LineItem.class_eval do
  class << self

    # Sales on product
    #  TODO нужно реализовать групировку данных в самом запросе
    # @param
    #   product_id
    #   parameters query
    # @return
    #   LineItem scope
    #
    def sale_by_product(product_id, params={ })
      @seatch_params = {:"products.id" => product_id}.merge(params)
      joins(:product).where(@seatch_params).
        select("sum(line_items.quantity) as units, sum(line_items.price) as total, line_items.created_at").
          group("line_items.created_at").order("line_items.created_at DESC")
    end

  end # end class << self
end
