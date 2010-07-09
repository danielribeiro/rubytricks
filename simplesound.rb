#!/usr/bin/ruby -w

require 'gst'

unless ARGV.length == 1
  $stderr.puts "Usage: #{__FILE__} <mp3 filename>"
  exit 1
end

# create a new pipeline to hold the elements
pipeline = Gst::Pipeline.new

# create a disk reader
filesrc = Gst::ElementFactory.make("filesrc")
filesrc.location = ARGV.first

# now it's time to get the decoder
decoder = Gst::ElementFactory.make("mad")

# and an audio sink
audiosink = Gst::ElementFactory.make("autoaudiosink")

# add objects to the main pipeline
pipeline.add(filesrc, decoder, audiosink)

# link elements
filesrc >> decoder >> audiosink

# create the program's main loop
loop = GLib::MainLoop.new(nil, false)

# listen to playback events
bus = pipeline.bus
bus.add_watch do |bus, message|
  case message.type
  when Gst::Message::EOS
    loop.quit
  when Gst::Message::ERROR
    p message.parse
    loop.quit
  end
  true
end

# start playing
pipeline.play
begin
  loop.run
rescue Interrupt
ensure
  pipeline.stop
end
