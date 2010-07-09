#!/usr/bin/env ruby
require 'net/http'
require 'http_encoding_helper'
headers={'Accept-Encoding' => 'gzip, deflate' }
http = Net::HTTP.new('http://api.twitter.com/1/followers/ids.xml?screen_name=BarackObama&cursor=-1', 80)
http.start do |h|
  request = Net::HTTP::Get.new('/', headers)
  response = http.request(request)
  content = response.plain_body
  puts "Transferred: #{response.body.length} bytes"
  puts "Compression: #{response['content-encoding']}"
  puts "Extracted: #{response.plain_body.length} bytes"
  puts "content = #{content}"
end
