#!/usr/bin/env ruby
require "hashie"
require "httparty"
require "yajl"
require 'pp'


module DeliciousNetwork
  include HTTParty
  format :json
  base_uri "http://feeds.delicious.com/v2/json"

  def self.parse(response)
    Yajl::Parser.parse(response.body)
  end

  def self.make_friendly(response)
    data = parse(response)
    # Don't mash arrays of integers
    pp data
    puts 'out of data'
    if data && data.is_a?(Array) && data.first.is_a?(Integer)
      data
    else
      mash(data)
    end
  end

  def self.perform_get(uri, options = {})
    make_friendly(get(uri, options))
  end

  def self.network
    perform_get("/networkmembers/hmason", {:count => 100})
  end
  

  def self.mash(obj)
    if obj.is_a?(Array)
      obj.map{|item| make_mash_with_consistent_hash(item)}
    elsif obj.is_a?(Hash)
      make_mash_with_consistent_hash(obj)
    else
      obj
    end
  end

  # Lame workaround for the fact that mash doesn't hash correctly
  def self.make_mash_with_consistent_hash(obj)
    m = Hashie::Mash.new(obj)
    def m.hash
      inspect.hash
    end
    return m
  end
end

for cara in DeliciousNetwork.network
    puts cara["user"]
end
