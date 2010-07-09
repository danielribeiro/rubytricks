require 'irb/completion'
IRB.conf[:AUTO_INDENT]=true
puts "Configure IRB: conf file at ~/.irbrc"
require 'rubygems'
require 'wirble'

Wirble.init
Wirble.colorize