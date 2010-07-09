#!/usr/bin/env ruby
Classe = "uma string"
def Classe.new
  return self
end

class A
  attr_accessor :service

  def initialize(generator = Classe)
    self.service = generator.new
  end
end

puts A.new.service