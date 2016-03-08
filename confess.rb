puts "=>> CONFESS for #{$0}: ruby version = #{RUBY_VERSION}"
require 'open3'

module SystemInstrumentation
  extend self

  def instrument_all
    instrument Kernel, :system, :spawn, :`, :exec
    instrument_class IO, :popen
    instrument_class Process, :spawn
  end

  def instrument(clazz, *methods)
    methods.each { |m| do_instrument(clazz, m) }
  end

  def instrument_class(clazz, *methods)
    methods.each { |m| do_instrument_class(clazz, m) }
  end

  def do_instrument(clazz, method)
    _any_instrument(clazz, method)
  end

  def do_instrument_class(clazz, method)
    _any_instrument(clazz, method, :singleton_method)
  end

  def _any_instrument(clazz, method, type = :method)
    original_method = clazz.__send__(type, method)
    stack = caller
    if stack.grep(/cocoapods/)
      stack = ["<cocoapods>"]
    end
    if stack.grep(/fail_on_error/)
      stack = ["<fail_on_error>"]
    end
    puts "Insturmenting #{type} #{original_method.inspect}"
    clazz.__send__("define_#{type}", method) do |*args|
      puts "--> Calling #{clazz}:#{method} with '#{args.inspect}' from:\n #{stack.join("\n")}"
      ret = original_method.call(*args)
      puts "--< Called #{clazz}:#{method} with '#{args.inspect}' returning #{ret.inspect}\n\n"
      ret
    end
  end

end
