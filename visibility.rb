#!/usr/bin/env ruby
class Pai
  private
  def m
    return 'oi'
  end

  def self.classprivate
    'classprivate'
  end

  class <<self
    private :classprivate
  end

end

class Son
  def invoke
    m
  end
end

#Not visible
#Pai.new.m

#Not visible
#Son.new.invoke

#Not visible as well
puts Pai.classprivate