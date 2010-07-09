#!/usr/bin/env ruby
eval "class Hi < Exception
  end"

puts Hi.name

  