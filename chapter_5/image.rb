framework 'Cocoa'

class CustomView < NSView

  def drawRect(rect)
    NSColor.whiteColor.set
    NSBezierPath.fillRect(rect)
    img_url = NSURL.URLWithString('http://bit.ly/apple_logo_png')
    img = NSImage.alloc.initWithContentsOfURL(img_url)
    img.drawAtPoint([0,0], fromRect: NSZeroRect, operation: NSCompositeSourceOver, fraction: 1)
  end
  
end

application = NSApplication.sharedApplication

# create the window
frame  = [100, 100, 152, 186]
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