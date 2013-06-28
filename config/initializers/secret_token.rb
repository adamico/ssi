# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
def find_secure_token
  Rails.env.development? ? 'a85b22aa2d4063ba6534bb6fa282331af00c97d238272a2c836fd54daf93c3f14fd039218832a17d42d7f921fcf5b2399537b0589567e0dd7348eae644358ac8' : ENV['APP_SECRET_TOKEN']
end

Ssi::Application.config.secret_token = find_secure_token
