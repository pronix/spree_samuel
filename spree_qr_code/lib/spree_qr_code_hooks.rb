class SpreeQrCodeHooks < Spree::ThemeSupport::HookListener
  insert_after :order_details_line_items_headers do
    %(
        <% if @order.line_items.any?(&:qr_code) %>
          <td class="qr_code"><%= "QR code" %></td>
          <td class="qr_code"><%= "Qty" %></td>
        <% end %>
     )
  end

  insert_after :order_details_line_item_row do
      %(
          <% if item.qr_code %>
            <td class="qr_code"><%= link_to (image_tag qr_code_path(:id => item.qr_code.code)),  qr_code_path(:id => item.qr_code.code, :size => QrCode::BIG_SIZE) %></td>
            <td class="qr_code"><%= item.qr_code.count - item.qr_code.used_count %></td>
          <% end %>
       )
  end
  insert_after :admin_product_form_left do
    %(
       <p>
        <%= f.label :generate_qr_code, t("generate_qr_code") %>
        <%= f.check_box :generate_qr_code%>
       </p>
     )
  end
end
