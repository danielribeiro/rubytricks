#!/usr/bin/ruby
# inspired on rackhash :http://github.com/sickill/racksh/blob/master/lib/racksh/version.rb
require "irb"
require "irb/completion"

reloaded = false
loop do
  pid = fork do
    require 'dump_methods'
    IRB.start

  end
  Process.wait(pid)
  break unless $?.exitstatus == 255
  reloaded = true
end
