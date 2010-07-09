#!/usr/bin/env ruby
class String
  def out
    puts self
  end
end

def call(name)
  "from #{name}".out
  yield
end

call(:name) { puts 'called'}

callp = lambda do |name|
  "fromp #{name}".out
  yield
end

#doesn't work
#callp.call(:name) { puts 'called'}
