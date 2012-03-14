#!/usr/bin/ruby
set_trace_func proc { 
  |event, file, line, id, binding, classname| 
  printf "!!! event = %8s, file/line = %s:%-2d, id=%10s classname=%8s\n", event, file, line, id, classname 
} 


5 + 5
