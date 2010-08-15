#!/usr/bin/ruby
require 'twitter'
 
# These credentials are specific to your *application* and not your *user*
# Get these credentials from Twitter directly: http://twitter.com/apps
application_token = 'JXm5SdORbEAQkE6xBQv12A'
application_secret = '9tLPKnojdMLz6XXulddnMxIIIyH6ujhlBMBG7WbfVtQ'
 
oauth = Twitter::OAuth.new(application_token,application_secret)
 
# request_token = oauth.request_token.token
# request_secret = oauth.request_token.secret
# puts "Request token => #{request_token}"
# puts "Request secret => #{request_secret}"
# puts "Authentication URL => #{oauth.request_token.authorize_url}"
 
# print "Provide the PIN that Twitter gave you here: "
# pin = gets.chomp
pin = 4179859

# oauth.authorize_from_request(request_token,request_secret,pin)
access_token = "166387569-IG8ps2qZCUeg8mhFh6jYmkvK16s2xyfEPhgbvIXF"
access_secret = "mVEPsHd1aI7JVe7VHkvIMZi0uiN0Wj8JYozcAXA"

# access_token = oauth.access_token.token
# access_secret = oauth.access_token.secret
# puts "Access token => #{oauth.access_token.token}"
# puts "Access secret => #{oauth.access_token.secret}"
 
oauth.authorize_from_access(access_token, access_secret)
twitter = Twitter::Base.new(oauth)
puts twitter.user_timeline(:count => 1)
