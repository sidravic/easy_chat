# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_easy_chat_session',
  :secret      => '781bce69f095763e8217f4dd5e0f9f8385c015a4c184a202def47d67721de1338103c0991c00a366a1f6bed88ee0a32ed3a57122fc46608de9a665895034eba6'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
