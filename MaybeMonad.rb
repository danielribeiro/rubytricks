#!/usr/bin/env ruby
require 'singleton'

class Option
  def pass
    raise "subclass responsability"
  end

  def value
    raise "subclass responsability"
  end

end

class Some < Option
  def initialize x
    @x = x
  end

  def pass(&block)
    return block.call value
  end

  def value
    @x
  end

  def method_missing(name, *args, &block)
    ret = @x.__send__ name, *args, &block
    return some(ret) unless ret.nil?
    retur none
  end
end


class None < Option
  include Singleton

  def pass
    return self
  end


  def method_missing(name, *args, &block)
    return self
  end

  def value
    raise "No Such Element"
  end
end

def none
  None.instance
end

def some x
  Some.new(x)
end

class TestMonad
  def getresult(arg)
    if arg > 10
      return some(arg)
    end
    return none
  end
end

class TestNonMonad
  def getresult(arg)
    if arg > 10
      return arg
    end
    return nil
  end
end


TestMonad.new.getresult(11).pass do |x|
  puts "the result was #{x}"
end

TestMonad.new.getresult(1).pass do |x|
  puts "the result was #{x}"
end

x = TestNonMonad.new.getresult(11)
if x
  puts "! the result was #{x}"
end

x = TestNonMonad.new.getresult(1)
if x
  puts "! the result was #{x}"
end

def test_monad_rule_3
  f = proc {|x| some(x * 2)}
  g = proc {|x| some(x + 1)}
  res1 = some(3).
    pass(&f).
    pass(&g).value
  res2 = some(3).pass{|x|
    f[x].
      pass {|y|g[y]} }.
    value
  puts "res 1 = #{res1}"
  puts "res 2 = #{res2}"
end


test_monad_rule_3
