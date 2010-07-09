#!/usr/bin/ruby
class Pai
  attr_accessor :nome

  def initialize()
    @nome = 'goodfather'
  end
end

class Filho < Pai
  attr_accessor :sobrenome

  def initialize(sobrenome)
    @sobrenome = sobrenome
    super()
  end
end

p = Pai.new()
puts p.nome

f = Filho.new('mafia')
puts f.nome
puts f.sobrenome