#!/usr/bin/env ruby
$TOTAL = 0
def selfcall(count)
  if count > 0
    $TOTAL += 1
    return selfcall(count - 1)
  end
  puts "returning as count is zero"
end

begin
  selfcall 6000
rescue SystemStackError => ex
  puts "Stacked out at #{$TOTAL}"
  raise
end

