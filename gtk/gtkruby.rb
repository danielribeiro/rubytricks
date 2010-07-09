#!/usr/bin/ruby

# ZetCode Ruby GTK tutorial
#
# In this program, we lay out widgets
# using absolute positioning
#
# author: jan bodnar
# website: www.zetcode.com
# last modified: June 2009
# from http://zetcode.com/tutorials/rubygtktutorial/layoutmanagement/

require 'gtk2'
require 'gst'



class MyButton < Gtk::Button
end

class RubyApp < Gtk::Window

  def song
    unless @playing
      @playing = true
      # create a new pipeline to hold the elements
      pipeline = Gst::Pipeline.new

      # create a disk reader
      filesrc = Gst::ElementFactory.make("filesrc")
      filesrc.location = 'whitelies.mp3'

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
        @playing = false
      end
    end
  end
  def initialize
    super
    
    set_title "Fixed"
    signal_connect "destroy" do 
      Gtk.main_quit 
    end
    
    init_ui

    set_default_size 300, 280
    set_window_position Gtk::Window::POS_CENTER
    
    show_all
  end
  
  def init_ui
    
    modify_bg Gtk::STATE_NORMAL, Gdk::Color.new(6400, 6400, 6440)
    
    begin       
      bardejov = Gdk::Pixbuf.new "google.gif"
      rotunda = Gdk::Pixbuf.new "google.gif"
      mincol = Gdk::Pixbuf.new "google.gif"
    rescue IOError => e
      puts e
      puts "cannot load images"
      exit
    end
    
    image1 = Gtk::Image.new bardejov
    image2 = Gtk::Image.new rotunda
    image3 = Gtk::Image.new mincol

    button = MyButton.new("Hello World")

    button.signal_connect("clicked") {
      puts "Hello World"
      
      song
    }

    
    fixed = Gtk::Fixed.new
    
    fixed.put image1, 20, 20
    fixed.put image2, 40, 160
    fixed.put image3, 170, 50
    fixed.put button, 50, 50
    
    add fixed
    
  end
end

Gtk.init
window = RubyApp.new
Gtk.main
