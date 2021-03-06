require 'prawn/layout'

font "Helvetica"
im = "#{Rails.root.to_s}/#{Spree::Config[:print_invoice_logo_path] || 'public/images/spree.jpg'}"

image im , :at => [0,720], :scale => 0.35

render :partial => "header"

move_down 4

font "Helvetica",  :size => 9,  :style => :bold
text "#{I18n.t(:order_number)} #{@order.number}", :align => :right

move_down 2
font "Helvetica", :size => 9
text "#{I18n.l @order.created_at.to_date}", :align => :right


render :partial => "address" rescue ''

move_down 30

render :partial => "line_items_box" rescue ''

move_down 8

# Footer
render :partial => "footer" rescue ''
