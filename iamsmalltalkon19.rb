#!/home/daniel/bin/jruby --1.9

module IAmSmalltalk
  def method_missing(name, *args, &block)
    puts "invoked method #{name} with args #{args.inspect}"
    puts "blockgiven? #{block_given?}"
    if args.size == 1 and args.first.kind_of? Hash
      h = args.first
      puts "lets play"
      argarray = [name].push *(h.keys)
      methodName = argarray.join "_"
      raise NoMethodError, "undefined method `#{methodName}' for #{self}" unless respond_to?(methodName)
      puts "sending: #{methodName}"
      return send methodName, *h.values, &block
    end
    puts "failed"
    super
  end
end

class Future
  include IAmSmalltalk
  def fn_match_path_flags(match, path, flags)
    puts "someone told me to fn with match #{match}, path #{path} and flags #{flags}"
  end
end

class Array
  include IAmSmalltalk
  alias remove_at delete_at
end


x = Future.new
x.fn match: '*', path: '/', flags: (%w[nao comente nunca].remove at: 1)
x.fn :match => '*', :path => '/', :flags => (%w[nao comente nunca].remove at: 1)

require 'json'
class A
  attr_accessor :name
end
puts A.to_json
