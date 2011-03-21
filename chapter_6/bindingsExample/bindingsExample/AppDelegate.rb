#
#  AppDelegate.rb
#  bindingsExample
#
#  Created by Matt Aimonetti on 3/20/11.
#  Copyright 2011 m|a agile Consulting. All rights reserved.
#

class AppDelegate
  attr_accessor :window
  attr_accessor :player
  
  def applicationDidFinishLaunching(a_notification)
    # Insert code here to initialize your application
  end
  
  def initialize 
    @player = Player.new
  end
  
end

