#!/usr/bin/env ruby
require 'pp'
module A
  def a
    'a'
  end
end


module B
  include A
  def b
    'b'
  end
end

module C
  include B
  def c
    'c'
  end
end

class Teste
  include C
end

pp C.ancestors
pp Teste.ancestors
x = Teste.new
pp x.c
pp x.b
pp x.a