#!/usr/bin/env ruby
def struct(*args)
  return Struct.new(*args)
end

class Args < struct :name, :args, :block
  def sendto(object)
    actualName = name.to_s
    actualArgs = []
    args.each_with_index do |value, i|
      if i.even?
        actualArgs << value
      else
        actualName += "_" + value.to_s
      end
    end
    if object.respond_to?(actualName)
      return object.send actualName, *actualArgs, &block
    end
    raise NoMethodError, "undefined method `#{actualName}' for #{self}"
  end
end

class Object
  def method_missing(name, *args, &block)
    return name if args.empty?
    puts "returning args for #{name} with #{args.inspect}"
    Args[name, args, block]
  end
end

class ArgsHolder
  def initialize(argsnames, args)
    @argsnames = argsnames
    @args = args
  end

  def method_missing(name, *args, &block)
    raise NoMethodError, "undefined method `#{name}' for #{self}" unless @argsnames.member? name
    @args[@argsnames.index name]
  end
end

class Class
  def defs(*args, &block)
    name = args.join "_"
    define_method(name) do |*innerargs|
      self.instance_exec(ArgsHolder.new(args, innerargs) ,&block)
    end
  end
end



class A
  def initialize
    @d = {}
  end

  def [] (args)
    args.sendto self
  end

  #  def put_at_with(key, value, othervalue)
  #    @d[key] = value, othervalue
  #  end
  defs :put, :at, :with do |i|
    @d[i.put] = i.at, i.with
  end

  def dict
    @d.inspect
  end
end

x = A.new
x[put 5, at, 'five', with, '6']

puts x.dict