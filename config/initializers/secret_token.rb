# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Srs::Application.config.secret_key_base = 'c0cffc6e29285f53cc702c362d6dad15e70'\
  '70697fd986e1a4556789dbfba1c993d27cfdd8d8ce9c2106cef49a170627d3d4da632d3c28b'\
  'f2b02d75263be02d86'
