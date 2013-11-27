# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Brewzly::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || 'fb56a56cc3ee43b101a8eb0405d4a1e38c449eb2481ac3a0fa62341cdf788aeba8d5e7ced5ecc7eba46eb4b4db7689fadb0b1af266d2190e26f6ac91405d5fe4'
