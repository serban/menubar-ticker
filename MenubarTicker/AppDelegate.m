//
//  AppDelegate.m
//  MenubarTicker
//
//  Created by Serban Giuroiu on 6/3/12.
//  Copyright (c) 2012 Serban Giuroiu. All rights reserved.
//

#import "AppDelegate.h"

#import "iTunes.h"
#import "Spotify.h"

const NSTimeInterval kPollingInterval = 0.5;


@interface AppDelegate ()

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) NSTimer *timer;

@end


@implementation AppDelegate

@synthesize statusItem;
@synthesize statusMenu;
@synthesize timer;

- (void)dealloc
{
    self.statusItem = nil;
    self.statusMenu = nil;
    
    [self.timer invalidate];
    self.timer = nil;
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:kPollingInterval
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
    SpotifyApplication *spotify = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    
    NSString *displayString = @"🎶"; // 🎵 or 🎶
    
    if ([iTunes isRunning] && [iTunes playerState] == iTunesEPlSPlaying) {
        iTunesTrack *currentTrack = [iTunes currentTrack];
        displayString = [NSString stringWithFormat:@"%@ - %@",
                         [currentTrack artist], [currentTrack name]];
    } else if ([spotify isRunning] && [spotify playerState] == SpotifyEPlSPlaying) {
        SpotifyTrack *currentTrack = [spotify currentTrack];
        displayString = [NSString stringWithFormat:@"%@ - %@",
                         [currentTrack artist], [currentTrack name]];
    }
    
    [statusItem setTitle:displayString];
}

@end
