#!/usr/bin/env ruby
require 'rubygems'
require 'yaml'
require 'wx'
include Wx

def out(arg)
  puts YAML.dump(arg)
end

class TroutApp < App
  def initialize
    super
    evt_close {|event| puts 'ended'  }
  end

  def on_init
    count = 0
    frame = Frame.new(nil, -1, "Title")
    text = StaticText.new(frame, -1, "You are a trout!",
              Point.new(-1, 1), DEFAULT_SIZE, ALIGN_CENTER)
    button = Button.new(frame, ID_ANY, "click me", Point.new(100,10))
    evt_button(button) { |e|
      text.set_label "Clicked #{count} times"
      count += 1
    }
    frame.show
  end

  def on_quit
    puts 'ended'
  end
end

TroutApp.new.main_loop
