#!/usr/bin/env ruby

module Enumerable
  def self.method_added(m)
    puts "added method #{m} from #{caller.inspect}"
  end
end

class InspectionMethod
  def initialize(target, methodName, type)
    @methodName = methodName
    @type = type
    @target = target
  end

  def name
    @methodName
  end

  def owner
    method.owner
  end

  def to_s
    "#{@type} #{owner}##{name} (#{arity})"
  end

  private
  def arity
    return "varargs: #{-method.arity - 1}+" if method.arity < 0
    return method.arity
  end

  def method
    @target.method(@methodName)
  end

end

class InspectionType
  def extract(object)
    raise "My sublcass should have overriden extract"
  end

  def +(inspectiontype)
    return CompositeInspectionType.new(types + inspectiontype.types)
  end

  def types
    return [self]
  end
end

class CompositeInspectionType < InspectionType
  def initialize(types = [])
    @types = types
  end

  def extract(object)
    @types.reduce() {|ret, type|
      ret + type.extract(object)
    }
  end

  def types
    return @types
  end
end

class SingleInspectionType < InspectionType
  def initialize(symbol, extractMethod = nil)
    @name = symbol
    if extractMethod == nil
      @extractMethod = (symbol.to_s + "_methods").to_sym
    else
      @extractMethod = extractMethod
    end
  end

  def extract(object)
    object.send(@extractMethod).map { |methodName|
      InspectionMethod.new(object, methodName, @name)
    }
  end
end


module InspectionTypes
  def self.createtype(symbol)
    SingleInspectionType.new(symbol)
  end

  PUBLIC = createtype :public
  PROTECTED = createtype :protected
  PRIVATE = createtype :private
  ALL = PUBLIC + PROTECTED + PRIVATE
end

class Inspector
  include InspectionTypes
  def printMethods(object, type = PUBLIC)
    out methods(object, type), object
  end

  def methods(object, type = PUBLIC)
    ret = type.extract(object).group_by &:owner
    ret.default = []
    return ret
  end

  private
  def out output, target
    order = target.class.ancestors.reverse
    outOf output, order
    outOf output, (output.keys - order).sort_by(&:to_s)
  end

  def outOf(output, order)
    for owner in order
      methodNames = output[owner]
      puts "#{owner}: #{methodNames.size}"
      for m in methodNames.sort_by(&:name)
        puts " #{m}"
      end
    end
  end

end


class Pai
  def self.onPai
    "on pai"
  end
end

class A < Pai
  def self.onClass
    "classmethod"
  end

  def oii
    "oi"
  end
end
x = A.new
class << x
  def  my_singleton
    "on my singleton"
  end
  self
end

def enhance(object)
  def object.sing
    return "sing"
  end
end


x = "variable"
enhance(x)
#puts x.sing

class W
  def self.oi
    'oi'
  end
  
  def self.lala
    'lala'
  end
end

class Q < W
  def self.lala
    'lala em q'
  end
  
  def self.a
    'A'
  end
end


include InspectionTypes
#Inspector.new.printMethods(lambda {||}, ALL)
#puts "\n\n\nfunction\n\n"
#require 'active_record'
Inspector.new.printMethods(Enumerable, PUBLIC)
#Inspector.new.printMethods(Class.new, ALL)
##puts "De Classe"
#Inspector.new.printMethods(A, PUBLIC)

#puts Q.a, Q.lala, Q.oii
