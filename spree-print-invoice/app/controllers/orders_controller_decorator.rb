OrdersController.class_eval do
  def show
    @order = Order.find_by_number(params[:id])
    if params[:format] == 'pdf'
      template = params[:template] || "invoice"
      render :layout => false , :template => "orders/#{template}.pdf.prawn"
    end
  end
end

