#!/usr/bin/env ruby
$the_continuation = nil
$hasCalled = false

def test
  i = 0
  callcc { |k|
    puts "setting the continuation"
    $the_continuation = k

  }
  ex = $hasCalled.to_s
  puts "has called = #{ex}"
  i += 1
  if $hasCalled
    puts "setting nill"
    $the_continuation = nil
  end
  puts "i was incremented. now it is #{i}"
  return i
end

puts "will i call it? #{not $hasCalled}"
if not $hasCalled
  puts "insisde hascalled"
  puts test()
  puts "test invoked"
  $hasCalled = true
  puts $the_continuation.call()
end