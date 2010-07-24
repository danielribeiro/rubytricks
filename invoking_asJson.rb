#!/usr/bin/env ruby
require 'active_support'
#Enumerable.send :undef_method, :to_json
#puts Module.public_instance_methods
#p Enumerable.
Alg = Struct.new :um, :dois
a = Alg.new 1, 2
out = a.to_json
p out