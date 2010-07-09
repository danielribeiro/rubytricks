#!/usr/bin/env ruby
require 'yaml'
require 'wx'
include Wx



# This class was automatically generated from XRC source. It is not
# recommended that this file is edited directly; instead, inherit from
# this class and extend its behaviour there.  
#
# Source file: wxtest/dialog.xrc 
# Generated at: Tue Dec 29 23:04:38 -0200 2009

class Meuframe < Wx::Frame
	
	def initialize(parent = nil)
		super()
		xml = Wx::XmlResource.get
		xml.flags = 2 # Wx::XRC_NO_SUBCLASSING
		xml.init_all_handlers
		xml.load("wxtest/dialog.xrc")
		xml.load_frame_subclass(self, parent, "ID_WXFRAME")

		finder = lambda do | x | 
			int_id = Wx::xrcid(x)
			begin
				Wx::Window.find_window_by_id(int_id, self) || int_id
			# Temporary hack to work around regression in 1.9.2; remove
			# begin/rescue clause in later versions
			rescue RuntimeError
				int_id
			end
		end
		
		if self.class.method_defined? "on_init"
			self.on_init()
		end
	end
end



 # Inherit from the generated base class and set up event handlers
 class CaseChangeFrame < Meuframe
   def initialize
     super
   end
 end

 # Run the class
 Wx::App.run do 
   CaseChangeFrame.new.show
 end
