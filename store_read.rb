#!/usr/bin/env ruby
require 'pstore'

store = PStore.new('data/myPersons')

def struct(*args)
  return Struct.new(*args)
end

Person = struct :name, :age


 store.transaction(true) do  # begin read-only transaction, no changes allowed
   store.roots.each do |data_root_name|
     p data_root_name
     p store[data_root_name]
   end
 end
