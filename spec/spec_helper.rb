require 'simplecov'
SimpleCov.start do
  add_filter "/spec/"
end

require 'rspec'
require_relative '../require_all'
