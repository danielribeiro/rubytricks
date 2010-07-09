#!/usr/bin/env ruby
class Object
  def metaclass
    class << self; self; end
  end
end

class Dave
  class << self
    def self.hi
      puts 'hi on meta'
    end
  end

  def self.regular
    puts 'regular'
  end

end

Dave.metaclass.hi
puts Dave.class.metaclass