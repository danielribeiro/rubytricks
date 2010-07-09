#!/usr/bin/env ruby
#
# This file is gererated by ruby-glade-create-template 1.1.4.
#
require 'libglade2'

class Helloworld3Glade
  include GetText

  attr :glade
  
  def initialize(path_or_data, root = nil, domain = nil, localedir = nil, flag = GladeXML::FILE)
    bindtextdomain(domain, localedir, nil, "UTF-8")
    @glade = GladeXML.new(path_or_data, root, domain, localedir, flag) {|handler| method(handler)}
    @window1 = @glade.get_widget("window1") # hand coded
    @window1.show # hand coded   
  end
  
  def on_button1_clicked(widget)
    # puts "on_button1_clicked() is not implemented yet."
    @window1.title = 'Hello World!' # hand coded  
  end

  def on_quit(widget, arg0)
    #puts "on_quit() is not implemented yet." # removed this code by hand
    Gtk.main_quit # hand coded

  end
end

# Main program
if __FILE__ == $0
  # Set values as your own application. 
  PROG_PATH = "helloworld3.glade"
  PROG_NAME = "YOUR_APPLICATION_NAME"
  Helloworld3Glade.new(PROG_PATH, nil, PROG_NAME)
  Gtk.main
end
