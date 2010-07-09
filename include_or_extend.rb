#!/usr/bin/env ruby
class Pai
  def out
    'out'
  end
end

class Son < Pai
  #  Expects module:
  #  extend Pai

  #  Expects module:
  #  include Pai
end

son = Son.new
puts son.out

module Mpai
  def inc
    'included'
  end
end

module MFilho
  include Mpai
  def incfilho
    "incfilho on #{self}"
  end
end

class Son
  include MFilho
end

puts son.inc
puts son.incfilho

module Exts
  extend MFilho
end

puts Exts.incfilho