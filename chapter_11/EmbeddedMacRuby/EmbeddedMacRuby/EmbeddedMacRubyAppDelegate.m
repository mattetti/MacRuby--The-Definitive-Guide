//
//  EmbeddedMacRubyAppDelegate.m
//  EmbeddedMacRuby
//
//  Created by Matt Aimonetti on 5/25/11.
//  Copyright 2011 m|a agile Consulting. All rights reserved.
//

#import "EmbeddedMacRubyAppDelegate.h"
#import <MacRuby/MacRuby.h>

@implementation EmbeddedMacRubyAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  // Insert code here to initialize your application
}

- (void)awakeFromNib
{
  NSFont *niceFont;
  
  niceFont = [NSFont fontWithName:@"Monaco" size:12.0];
  [rubySourceTextView setFont:niceFont];
  [resultTextView setFont:niceFont];
  
  id appHelper = [[MacRuby sharedRuntime] evaluateString:@"module App;\
                    def self.window=(val); @window=val; end;\
                    def self.window; @window; end; end; App"];
  [appHelper performRubySelector:sel_registerName("window=:") 
                                withArguments:window, nil];  
  [rubySourceTextView setString:@"App.window.title = 'W00t'"];
}



- (IBAction)evaluate:(id)sender
{
  @try {
    id object;
    
    object = [[MacRuby sharedRuntime] evaluateString:[rubySourceTextView string]];
    [resultTextView setString:[object description]];
  }
  @catch (NSException *exception) {
    NSString *string = [NSString stringWithFormat:@"%@: %@\n%@", 
                           [exception name], [exception reason], 
                        [[[exception userInfo] objectForKey:@"backtrace"] description]];
    [resultTextView setString:string];
  }
}

@end
