#!/usr/bin/env ruby
class Lazy
  def lazyint
    @int ||= 5
  end
end

puts Lazy.new.lazyint