# mouse_coordinates_loop.rb
# demo
#
# Created by Matt Aimonetti on 12/12/10.
# Copyright 2010 m|a agile. All rights reserved.

module MouseCoordinatesLoop
  
  def start_updating_coordinates(sender)
    puts "start updating the mouse coordinates"
    @timer = NSTimer.scheduledTimerWithTimeInterval 0.5,
                                           target: self,
                                           selector: 'update_mouse_location_info:',
                                           userInfo: nil,
                                           repeats: true
  end
  
  def stop_updating_coordinates(sender)
    @timer.invalidate && @timer = nil if @timer
  end
  
end
