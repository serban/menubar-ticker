//
//  AppDelegate.m
//  MenubarTicker
//
//  Created by Serban Giuroiu on 6/3/12.
//  Copyright (c) 2012 Serban Giuroiu. All rights reserved.
//

#import "AppDelegate.h"

#import "iTunes.h"
#import "Rdio.h"
#import "Spotify.h"

const NSTimeInterval kPollingInterval = 10.0;


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
    [[NSDistributedNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    
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
                                                selector:@selector(timerDidFire:)
                                                userInfo:nil
                                                 repeats:YES];
    
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(didReceivePlayerNotification:)
                                                            name:@"com.apple.iTunes.playerInfo"
                                                          object:nil];
    
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(didReceivePlayerNotification:)
                                                            name:@"com.rdio.desktop.playStateChanged"
                                                          object:nil];
    
    [[NSDistributedNotificationCenter defaultCenter] addObserver:self
                                                        selector:@selector(didReceivePlayerNotification:)
                                                            name:@"com.spotify.client.PlaybackStateChanged"
                                                          object:nil];
}

- (void)awakeFromNib
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.menu = self.statusMenu;
    self.statusItem.highlightMode = YES;
    self.statusItem.toolTip = @"Menu Bar Ticker";
    
    [self updateTrackInfo];
}


- (void)updateTrackInfo
{
    iTunesApplication *iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    RdioApplication *rdio = [SBApplication applicationWithBundleIdentifier:@"com.rdio.desktop"];
    SpotifyApplication *spotify = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    
    NSString *displayString = @"🎶"; // 🎵 or 🎶
    
    if ([iTunes isRunning] && [iTunes playerState] == iTunesEPlSPlaying) {
        iTunesTrack *currentTrack = [iTunes currentTrack];
        displayString = [NSString stringWithFormat:@"%@ - %@",
                         [currentTrack artist], [currentTrack name]];
    } else if ([rdio isRunning] && [rdio playerState] == RdioEPSSPlaying) {
        RdioTrack *currentTrack = [rdio currentTrack];
        displayString = [NSString stringWithFormat:@"%@ - %@",
                         [currentTrack artist], [currentTrack name]];
    } else if ([spotify isRunning] && [spotify playerState] == SpotifyEPlSPlaying) {
        SpotifyTrack *currentTrack = [spotify currentTrack];
        displayString = [NSString stringWithFormat:@"%@ - %@",
                         [currentTrack artist], [currentTrack name]];
    }
    
    statusItem.title = displayString;
}

- (void)timerDidFire:(NSTimer *)theTimer
{
    [self updateTrackInfo];
}

- (void)didReceivePlayerNotification:(NSNotification *)notification
{
    [self updateTrackInfo];
}

@end
