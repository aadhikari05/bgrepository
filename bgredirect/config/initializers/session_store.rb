# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bgredirect_session',
  :secret      => '07836518f5357837de2d69e0d8a60091a8ccdc00f9418c1a263b491bb830999b26e5afaa1df5a406f873d4f676d36ddbfbcf2397c7ed51d4609f9f9f7f6b9046'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
