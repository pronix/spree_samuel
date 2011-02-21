class SamuelHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_sub_tabs do
    %(
          <%= tab :inventory %>

)
  end
  insert_after :admin_tabs do
    %(<%=  tab(:track_accounts)  %>)
  end
  insert_after :seller_tabs do
    %(<%=  tab(:track_accounts)  %>)
  end

end
