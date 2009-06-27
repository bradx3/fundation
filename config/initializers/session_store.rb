# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_offset_session',
  :secret      => '2daca8a6f9d709bb897aafb8fcf4a4688a5130a976cb7ff847a1db5f1f6985893d8398b059b95692c66a6c993eedc57a5a3374384b126723a4710cca4d8e6cd9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
