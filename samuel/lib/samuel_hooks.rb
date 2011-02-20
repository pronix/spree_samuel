class SamuelHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_product_sub_tabs do
    %(
          <%= tab :inventory %>

)
  end
end
