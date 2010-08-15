#!/usr/bin/env ruby
module ClassExtension
  @@var = "module var"
  def printvar
    puts @@var
  end
end

class A
  @@var = 'A class variable'
  extend ClassExtension
end

A.printvar #prints module var