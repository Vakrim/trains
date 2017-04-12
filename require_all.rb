require 'gosu'
require 'ostruct'
require 'pry'
require 'matrix'

Dir[File.dirname(__FILE__) + '/concepts/*.rb'].each {|file| require file }

module Behavior; end
Dir[File.dirname(__FILE__) + '/behaviors/*.rb'].each {|file| require file }

class Actor; end
Dir[File.dirname(__FILE__) + '/actors/*.rb'].each {|file| require file }
