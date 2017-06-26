require 'gosu'
require 'ostruct'
require 'pry'
require 'matrix'
require 'set'
require 'weakref'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

Dir[File.dirname(__FILE__) + '/concepts/*.rb'].each {|file| require file }

Dir[File.dirname(__FILE__) + '/behaviours/*.rb'].each {|file| require file }

module Behavior; end
Dir[File.dirname(__FILE__) + '/behaviors/*.rb'].each {|file| require file }

class Actor; end
Dir[File.dirname(__FILE__) + '/actors/*.rb'].each {|file| require file }
