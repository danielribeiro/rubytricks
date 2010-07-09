#!/usr/bin/env ruby
class A
  def sayhi
    say
    hi
  end

  private
  def say
    puts 'a says'
  end

  def hi
    puts 'a hi'
  end
end

class B < A
  def hi
    puts 'b bye'
  end
end

A.new.sayhi

B.new.sayhi