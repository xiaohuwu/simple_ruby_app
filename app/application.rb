# frozen_string_literal: true

ENV['ENVIRONMENT'] ||= 'development'

require 'mysql2'
require 'active_record'
require 'dotenv'
require 'yaml'
require 'erb'

require 'app/models/student'
require 'app/models/post'

require 'app/runner'

Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')

def db_configuration
  db_configuration_file_path = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
  db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result

  YAML.safe_load(db_configuration_result, aliases: true)
end



ActiveRecord::Base.logger = ActiveSupport::Logger.new("log/#{ENV['ENVIRONMENT']}.log")

# To disable the ANSI color output:
ActiveSupport::LogSubscriber.colorize_logging = false


ActiveRecord::Base.establish_connection(db_configuration[ENV['ENVIRONMENT']])

module Application
  class Error < StandardError; end
  # Your code goes here...
end
