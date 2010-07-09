#!/usr/bin/env ruby
def myclasse(nome, &block)
  vclasse = Class.new(&block)
  eval "#{nome} = vclasse"

end

myclasse "Oi" do
  def sayOi
    puts 'oi'
  end
end

Oi.new.sayOi