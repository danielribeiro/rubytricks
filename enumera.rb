#!/usr/bin/env ruby

ARGF.each_with_index do |line, idx|
  print idx + 1, ". ", line
end


