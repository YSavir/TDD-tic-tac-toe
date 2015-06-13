require 'pry'
require 'rspec/collection_matchers'

require_relative '../lib/tic_tac_toe.rb'
Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }

RSpec.configure do |c|
  c.include IOHelpers
end

