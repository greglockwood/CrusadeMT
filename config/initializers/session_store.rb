# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_crusademt_session',
  :secret      => 'ac6a292b4479d851c408c1f4a79574e9dffb736396943398473abc733237e63ae9634c99b26826ee78a52a050d7511b9450f42b1a01cf523cdf2dcd0f3e69b31'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
