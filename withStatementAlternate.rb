#!/usr/bin/env ruby
require 'yaml'
class Email
  attr_accessor :to, :from, :subject, :cc

  def with(&block)
    instance_eval(&block)
  end

end

mail = Email.new
mail.with do
  @from = 'me@gmail.com'
  @subject = 'metaphysics'
  @to = 'everybody@gmail.com'
  @cc = 'CIA@usa.gov'
end

puts "alternate"
puts YAML.dump(mail)