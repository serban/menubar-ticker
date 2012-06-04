//
//  AppDelegate.m
//  MenubarTicker
//
//  Created by Serban Giuroiu on 6/3/12.
//  Copyright (c) 2012 Serban Giuroiu. All rights reserved.
//

#import "AppDelegate.h"

#import "iTunes.h"

const NSTimeInterval kPollingInterval = 0.5;


@interface AppDelegate ()

@property (nonatomic, retain) NSStatusItem *statusItem;

@end


@implementation AppDelegate

@synthesize statusItem;
@synthesize statusMenu;

- (void)dealloc
{
    self.statusMenu = nil;
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [NSTimer scheduledTimerWithTimeInterval:kPollingInterval
                                     target:self
                                   selector:@selector(updateTrackInfo:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)awakeFromNib
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    [self.statusItem setHighlightMode:YES];
}

- (void)updateTrackInfo:(NSTimer *)theTimer
{
    iTunesApplication *iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    
    NSString *displayString = nil;
    
    if ([iTunes isRunning] && [iTunes playerState] == iTunesEPlSPlaying) {
        iTunesTrack *currentTrack = [iTunes currentTrack];
        displayString = [NSString stringWithFormat:@"%@ - %@",
                         [currentTrack artist], [currentTrack name]];
    }
    
    [statusItem setTitle:displayString];
}

@end
