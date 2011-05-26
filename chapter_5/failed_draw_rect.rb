framework 'Cocoa'

class CustomView < NSView

  def drawRect(rect)
    # draw a red background
    NSColor.redColor.set
    NSBezierPath.fillRect(rect)
    
    # draw a rectangle
    path = NSBezierPath.bezierPath
    path.lineWidth = 2
    # starting point
    path.moveToPoint [100, 50]
    # draw a rectangle                     
    path.lineToPoint [100, 100]
    path.lineToPoint [200, 100]
    path.lineToPoint [200, 50]
    # close the rectangle automatically
    path.closePath
    path.stroke
  end
  
end

application = NSApplication.sharedApplication

# create the window
frame  = [0.0, 0.0, 300, 200]
mask = NSTitledWindowMask | NSClosableWindowMask
window = NSWindow.alloc.initWithContentRect(frame,
          styleMask:mask,
          backing:NSBackingStoreBuffered,
          defer:false)

# assign a content view instance
content_view = CustomView.alloc.initWithFrame(frame)
window.contentView = content_view

# show the window
window.display
window.makeKeyAndOrderFront(nil)
window.orderFrontRegardless

application.run