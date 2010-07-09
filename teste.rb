#!/usr/bin/ruby

class Foo
  def meu:(arg) nome:(arg2) e: => meu_nome_e
    puts 1
  end
end


x = 5
class << x
  def method2
    puts 2
  end  
end


x.method2

