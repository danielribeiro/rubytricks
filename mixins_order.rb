#!/usr/bin/env ruby
module Person
  def hours
    raise("Subclass responsability")
  end
end

module Student
  include Person
  def hours
    24
  end
end

module Worker
  include Person
  def hours
    8
  end
end

class CollegeStudent
  include Worker
  include Student

end

puts CollegeStudent.new.hours