# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
TextEpic::Application.initialize!

Rails.logger = Logger.new("#{Rails.env}_log.txt")

