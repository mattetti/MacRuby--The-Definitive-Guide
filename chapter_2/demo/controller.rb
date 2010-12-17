# controller.rb
# demo
#
# Created by Matt Aimonetti on 12/12/10.
# Copyright 2010 m|a agile. All rights reserved.

class Controller
  
  # The main UI window. Once the connection with the UI done, you can call the window getter
  # to programmatically access the window object.
  attr_accessor :window
  
  # Textfield and labels demo
  attr_accessor :demo_label, :demo_textfield, :update_label_btn
  
  # mouse position coordinate labels
  attr_accessor :mouse_x, :mouse_y
  attr_accessor :start_btn, :stop_btn
  
  # image placeholder used to show the visual effects & drag'n drop
  attr_accessor :image_placeholder
  
  # text field used to print debug information
  attr_accessor :debug_field
  
  # Sets the demo label text to the content of the text field.
  def update_text_field(sender)
    demo_label.stringValue = demo_textfield.stringValue
    debug "Label text updated with new text:\n #{demo_textfield.stringValue}"
  end
  
  # Delegate automatically called when the window will be closed because
  # we set this class as the delegate of the window.
  #
  # This action is also set to be called when the "Quit button" is pushed.
  #
  # @param [NSConcreteNotification, Object] sender triggering the window to close.
  # 
  # @return [NilClass] The application would or quit or output to the console.
  def windowShouldClose(sender)
    confirmation =  alert("Closing", "Are you sure you want to exit this application?")
    # The confirmtion modal will return 1 or -1
    if confirmation == 1
      exit
    else
      # For Objective-C developer, this is the same as writing the following obj-c code:
      # NSLog(@"Ok, nevermind")
      puts "Ok, nevermind"
      debug "Not quiting after all"
    end
  end
  
  def windowDidResize(notification)
    debug "Window resized:\n  x=#{window.frame[0].x}, y=#{window.frame[0].y}\n  width=#{window.frame[1].width}, height=#{window.frame[1].height}"
  end
  
  def windowDidMove(notification)
    debug "Window moved:\n  x=#{window.frame[0].x}, y=#{window.frame[0].y}"
  end
  
  # The alert method display a modal box asking a question
  #
  # @param [String] title The model box's title.
  # @param [String] message The question asked to the user.
  #
  # @return [Fixnum] 1 if the user pressed the OK button, -1 if he pressed the cancel button instead.
  def alert(title='Alert', message='Are you sure?')
    NSAlert.alertWithMessageText(title, 
                                 defaultButton: 'OK',
                                 alternateButton: nil, 
                                 otherButton: 'Cancel',
                                 informativeTextWithFormat: message).runModal
  end
  
  # Update the mouse coordinate based on a timer.
  def start_updating_coordinates(sender)
    debug "Start updating the mouse coordinates"
    @timer = NSTimer.scheduledTimerWithTimeInterval 0.05,
                                           target: self,
                                           selector: 'update_mouse_location_info:',
                                           userInfo: nil,
                                           repeats: true
    start_btn.enabled = false
    stop_btn.enabled = true
  end
  
  # Stopping the timer which updates the mouse coordinates
  def stop_updating_coordinates(sender)
    debug "Stop updating the mouse coordinates"
    @timer.invalidate && @timer = nil if @timer
    start_btn.enabled = true
    stop_btn.enabled = false
  end
  
  # method called by the timer
  def update_mouse_location_info(sender)
    coordinates = NSEvent.mouseLocation
    mouse_x.stringValue = "x: #{coordinates.x}"
    mouse_y.stringValue = "y: #{coordinates.y}"
  end
  
  # Apply sepia effect on the image 
  def sepia(sender)
    context = NSGraphicsContext.currentContext.CIContext
    data = image_placeholder.image.TIFFRepresentation    
    current_image = CIImage.imageWithData(data)
    
    # See all available filters by calling CIFilter.filterNamesInCategories(nil).sort
    filter = CIFilter.filterWithName("CISepiaTone")
    filter.setDefaults
    filter.setValue(current_image, forKey: "inputImage") 
    converted_image = ciimage_to_nsimage(filter.outputImage)
    image_placeholder.image = converted_image
    debug "Applied a sepia filter"
  end
  
  # Apply a pixelization effect on the image
  def pixelize(sender)
    context = NSGraphicsContext.currentContext.CIContext
    data = image_placeholder.image.TIFFRepresentation    
    current_image = CIImage.imageWithData(data)
    
    # See all available filters by calling CIFilter.filterNamesInCategories(nil).sort
    filter = CIFilter.filterWithName("CICrystallize")
    filter.setDefaults
    filter.setValue(3.0, forKey: "inputRadius")
    
    filter.setValue(current_image, forKey: "inputImage") 
    converted_image = ciimage_to_nsimage(filter.outputImage)
    image_placeholder.image = converted_image
    debug "Pixelizing the image"
  end

  
  private
  
  # Print a debug message
  def debug(msg)
    debug_field.stringValue = msg
  end
  
  # convert a CIImage instance to a NSImage one
  def ciimage_to_nsimage(ci_img)
    converted_image = NSImage.alloc.initWithSize( NSMakeSize(ci_img.extent.size.width, ci_img.extent.size.height))
    converted_image.lockFocus
    NSGraphicsContext.currentContext.CIContext.drawImage(ci_img, atPoint:CGPointMake(0, 0), fromRect: ci_img.extent)
    converted_image.unlockFocus
    converted_image
  end
  
end