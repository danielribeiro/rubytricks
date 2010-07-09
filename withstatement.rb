#!/usr/bin/env ruby
require 'pp'
require 'yaml'

class Wrapper
  def initialize(wrapped)
    @wrapped = wrapped
  end

  def method_missing(m, *args, &block)
    setter = m.to_s + '='
    if @wrapped.respond_to?(setter)
      @wrapped.send(setter, *args, &block)
    else
      raise NoMethodError
    end
    return self
  end
end


class Email
  attr_accessor :to, :from, :subject, :cc


  def with(&block)
    Wrapper.new(self).instance_eval(&block)
  end

end

mail = Email.new
mail.with do
  from 'me@gmail.com'
  subject  'metaphysics'
  to 'everybody@gmail.com'
  cc 'CIA@usa.gov'
end


puts YAML.dump(mail)