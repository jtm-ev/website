# Load the rails application
require File.expand_path('../application', __FILE__)

NEGATIVE_CAPTCHA_SECRET = "c29ba3d18d36d035559de55b656f069c0c8a4b6a389c57387ac821b1b253de1bc301773410fbd91f29e9df3f3f0fceabee46f3fdd48683652f354b7ac7d9e84c"

# Initialize the rails application
Website::Application.initialize!
