#!/usr/bin/env ruby
module MetaA
  def meta
    puts "em meta"
  end
end

module A
  extend MetaA
  def ema
    puts 'ema'
  end
end

class X
  include A
  meta
  def x
    ema
  end
end

X.new.x