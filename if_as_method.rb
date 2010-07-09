#!/usr/bin/env ruby
module TrueMod
  def ifTrue(&block)
    yield
  end

  def ifFalse(&block)

  end
end

module FalseMod
  def ifTrue(&block)

  end

  def ifFalse(&block)
    yield
  end
end

class TrueClass
  include TrueMod
end

class FalseClass
  include FalseMod
end

class Fixnum
  include TrueMod

  def ifTrue(&block)
    if self != 0
      super
    end
  end
end

(5 == 6).ifFalse do
  puts "e true"
end

if 0
  puts "0 e true"
end

0.ifTrue do
  puts "erro!!"
end

1.ifTrue do
  puts "Voltamos ao C"
end

