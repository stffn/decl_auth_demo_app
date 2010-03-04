# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_decl_auth_demo_app_session',
  :secret => 'c6f35430c6bb6c3eb3f3fefd1c7277f8436bc76d499577bf1f7f020c7f61999a5f094502fe0277da83827013793edd38b04b86d4412599a5e2c93d8fae8a7481'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
