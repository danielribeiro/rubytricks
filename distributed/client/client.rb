#!/usr/bin/env ruby
require 'drb'
DRb.start_service()
obj = DRbObject.new(nil, 'druby://localhost:9049')
# Now use obj
p obj.doit(File.open('oiemfile')) { |who| "just something #{who} gave you"}

