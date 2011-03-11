# Access Key ID AKIAJEPLR4RUTODWT7NQ   
#
# Secret Access Key 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
#
begin
  FCG::Service::Client.configure do |config|
    config.api_key      = FCG_CONFIG.app.fcg_api_key
    config.host         = FCG_CONFIG.app.service_host
    config.port         = FCG_CONFIG.app.service_port
  end
rescue Exception => e
  raise "make sure you have a valid api_key, host, and post for FSC aka FCG Service Client."
end
