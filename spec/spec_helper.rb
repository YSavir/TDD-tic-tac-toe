require 'pry'
require 'rspec/collection_matchers'
require 'factory_girl'

require_relative '../lib/tic_tac_toe.rb'
Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }
Dir["spec/factories/**/*.rb"].each { |f| require File.expand_path(f) }

RSpec.configure do |c|
  c.include Iodize
  c.include FactoryGirl::Syntax::Methods
end

Pry.config.input = STDIN
Pry.config.output = STDOUT

