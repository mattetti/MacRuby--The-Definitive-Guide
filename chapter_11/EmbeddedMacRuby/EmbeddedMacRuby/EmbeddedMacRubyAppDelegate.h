//
//  EmbeddedMacRubyAppDelegate.h
//  EmbeddedMacRuby
//
//  Created by Matt Aimonetti on 5/25/11.
//  Copyright 2011 m|a agile Consulting. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface EmbeddedMacRubyAppDelegate : NSObject <NSApplicationDelegate> {
  IBOutlet NSTextView *rubySourceTextView;
  IBOutlet NSTextView *resultTextView;
  
@private
  NSWindow *window;
}

- (IBAction)evaluate:(id)sender;

@property (assign) IBOutlet NSWindow *window;

@end
