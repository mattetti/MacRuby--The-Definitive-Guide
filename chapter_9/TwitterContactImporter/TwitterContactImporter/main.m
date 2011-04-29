//
//  main.m
//  TwitterContactImporter
//
//  Created by Matt Aimonetti on 4/28/11.
//  Copyright 2011 m|a agile Consulting. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <MacRuby/MacRuby.h>

int main(int argc, char *argv[])
{
  return macruby_main("rb_main.rb", argc, argv);
}
