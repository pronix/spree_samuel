# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_app_new_session',
  :secret      => '60ca8fbab04a71ce932155718a0e0e3db2838b4adc6c7be5518fa778c660159849fd6d8959dfdc13c51e591049e9ad32b9ef60806750e48a5dd1616ac50a1108'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
