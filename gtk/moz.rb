#!/usr/bin/ruby
# from http://ruby-gnome2.sourceforge.jp/hiki.cgi?Gtk%3A%3AMozEmbed

require 'gtk2'


w = Gtk::Window.new
w.title = "Lean & mean browser"
w.resize(780, 570)

socket = Gtk::Socket.new
socket.show
w.add(socket)

# The following call is only necessary if one of
# the ancestors of the socket is not yet visible.
socket.realize
puts "The ID of the sockets window is #{socket.id}"
Gtk.main
