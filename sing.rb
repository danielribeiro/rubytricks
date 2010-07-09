#!/usr/bin/ruby
require 'singleton'
class Hermit
  include Singleton
end

puts Hermit.instance
puts Hermit.instance
puts Hermit.instance

