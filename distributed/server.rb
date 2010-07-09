#!/usr/bin/env ruby
require 'drb'
require 'drb/acl'

class TestServer
  def doit(f, &block)
    ret = "Hello, Distributed World " + yield("god") + " with io = #{f.read}" 
    puts "returning #{ret}"
    return ret
  end
end

puts "Started Test Server"
begin
  aServerObject = TestServer.new
#  acl = ACL.new( %w[deny all] )
#  DRb.install_acl(acl)
  DRb.start_service('druby://localhost:9049', aServerObject)
  DRb.thread.join # Don't exit just yet!
rescue Exception => ex
  puts ex
ensure
  puts "Ended"
end

