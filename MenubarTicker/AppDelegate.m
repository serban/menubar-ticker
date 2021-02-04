#import "AppDelegate.h"

#import "iTunes.h"
#import "Music.h"
#import "Rdio.h"
#import "Spotify.h"

const NSTimeInterval kPollingInterval = 10.0;


@interface AppDelegate ()

@property (nonatomic, retain) iTunesApplication *iTunes;
@property (nonatomic, retain) MusicApplication *music;
@property (nonatomic, retain) RdioApplication *rdio;
@property (nonatomic, retain) SpotifyApplication *spotify;

@property (nonatomic, retain) NSStatusItem *statusItem;
@property (nonatomic, retain) NSTimer *timer;

@end


@implementation AppDelegate

@synthesize iTunes;
@synthesize music;
@synthesize rdio;
@synthesize spotify;

@synthesize statusItem;
@synthesize statusMenu;
@synthesize timer;

- (void)dealloc
{
    [[NSDistributedNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];

    self.iTunes = nil;
    self.music = nil;
    self.rdio = nil;
    self.spotify = nil;
    
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
                                                            name:@"com.apple.music.playerInfo"
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
    self.iTunes = [SBApplication applicationWithBundleIdentifier:@"com.apple.iTunes"];
    self.music = [SBApplication applicationWithBundleIdentifier:@"com.apple.music"];
    self.rdio = [SBApplication applicationWithBundleIdentifier:@"com.rdio.desktop"];
    self.spotify = [SBApplication applicationWithBundleIdentifier:@"com.spotify.client"];
    
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    self.statusItem.menu = self.statusMenu;
    self.statusItem.button.toolTip = @"Menu Bar Ticker";
    
    [self updateTrackInfo];
}


- (void)updateTrackInfo
{
    id currentTrack = nil;
    
    if ([self.iTunes isRunning] && [self.iTunes playerState] == iTunesEPlSPlaying) {
        currentTrack = [self.iTunes currentTrack];
    } else if ([self.music isRunning] && [self.music playerState] == MusicEPlSPlaying) {
        currentTrack = [self.music currentTrack];
    } else if ([self.rdio isRunning] && [self.rdio playerState] == RdioEPSSPlaying) {
        currentTrack = [self.rdio currentTrack];
    } else if ([self.spotify isRunning] && [self.spotify playerState] == SpotifyEPlSPlaying) {
        currentTrack = [self.spotify currentTrack];
    }

    statusItem.button.title = currentTrack
        ? [NSString stringWithFormat:@"%@ - %@", [currentTrack artist], [currentTrack name]]
        : @"♫";
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
