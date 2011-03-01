class SpreeAuthorizeNetReportsHooks < Spree::ThemeSupport::HookListener
  insert_after :admin_tabs do
    %(<%=  tab(:transactions)  %>)
  end
end