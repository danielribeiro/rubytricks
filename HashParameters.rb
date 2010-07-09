#!/usr/bin/env ruby
def func(h = {})
  puts h.inspect
end

class HashBuilder
  def initialize
    @hash = {}
  end

  def method_missing(name, *args)
    @hash[name] = args[0]
    return self
  end

  def inspect
    return @hash.inspect
  end
end

class HashDSL
  def initialize(&block)
    @hash = {}
    instance_eval(&block)
  end

  def method_missing(name, *args)
    if args.size == 0
      return name
    end
    @hash[name] = args[0]
    return self
  end

  def inspect
    return @hash.inspect
  end
end

def arg
  return HashBuilder.new
end

def args(&block)
  HashDSL.new &block
end

func(arg.um('dois').dois(2))

x = HashDSL.new do
  pt portugues
  en ingles
end
puts x.inspect

func args {um 'dois'; dois 2}