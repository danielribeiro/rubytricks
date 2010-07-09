#!/usr/bin/env ruby
class A
  def self.multi(name, &block)
    define_method(name, &block)
  end

  @lala = 'class lala'

  def initialize
    @lala = 'lala'
  end

  multi :id do |x|
    return x
  end

  multi :works do
    @lala
  end
end


puts A.new.id 5
puts A.new.works