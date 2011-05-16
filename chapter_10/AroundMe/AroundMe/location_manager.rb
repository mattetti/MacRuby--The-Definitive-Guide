#
#  location_manager.rb
#  AroundMe
#
#  Created by Matt Aimonetti on 5/15/11.
#  Copyright 2011 m|a agile Consulting. All rights reserved.
#

framework 'CoreLocation'

# CLLocationManager wrapper
# more info on the CoreLocation:
# http://developer.apple.com/library/ios/#documentation/CoreLocation/Reference/CLLocationManager_Class/CLLocationManager/CLLocationManager.html
class LocationManager
  
  def initialize(&block)
    @loc          = CLLocationManager.alloc.init
    @loc.delegate = self
    @callback     = block
  end
  
  def start
    @loc.startUpdatingLocation
  end
  
  def stop
    @loc.stopUpdatingLocation
  end
  
  # Dispatch the CLLocationManager callback to the Ruby callback
  def locationManager(manager, didUpdateToLocation: new_location, 
                               fromLocation: old_location)
    @callback.call(new_location, self)
  end
  
end
