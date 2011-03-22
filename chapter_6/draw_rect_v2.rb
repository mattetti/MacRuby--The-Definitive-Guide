framework 'Cocoa'

class CustomView < NSView

  # Using a method yielding a block, we can keep
  # our code cleaner
  def temp_context(&block)
    context = NSGraphicsContext.currentContext
    context.saveGraphicsState
    yield
    context.restoreGraphicsState
  end

  def drawRect(rect)
    # draw a red background
    temp_context do
      NSColor.redColor.set
      NSBezierPath.fillRect(rect)
    end
    
    path = NSBezierPath.bezierPath
    path.lineWidth = 2
    # starting point
    path.moveToPoint [100, 50]
    # draw a rectangle                     
    path.lineToPoint [100, 100]
    path.lineToPoint [200, 100]
    path.lineToPoint [200, 50]
    # close the path automatically
    path.closePath
    
    # fill the content of the path in transparent white
    temp_context do
      NSColor.colorWithCalibratedWhite(0.9, alpha: 0.5).set
      NSBezierPath.fillRect([100, 50, 100, 50])
    end
    
    # draw the rectangle stroke after the content was filled
    path.stroke
    
    # draw some text, because we are changing the context shadow
    # we are doing that in a temp context
    temp_context do
      shadow = NSShadow.alloc.init
      shadow.shadowOffset = [4, -4]
      shadow.set
      font = NSFont.fontWithName("Helvetica", size:24)
      attributes = {NSFontAttributeName => font, NSForegroundColorAttributeName => NSColor.whiteColor}
      "MacRuby Rocks".drawAtPoint([60, 120], withAttributes: attributes)
    end
  end
  
end

application = NSApplication.sharedApplication

# create the window
frame  = [0.0, 0.0, 300, 200]
mask = NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask
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