#!/usr/bin/env ruby
require 'pstore'

store = PStore.new('data/myPersons')

def struct(*args)
  return Struct.new(*args)
end

Person = struct :name, :age

puts "doing it"
store.transaction do
  for i in 1..1500000
    store[i] = Person.new "randomPerson#{i}", i
  end
end
puts 'done'