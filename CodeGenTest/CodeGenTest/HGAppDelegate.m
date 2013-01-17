//
//  HGAppDelegate.m
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import "HGAppDelegate.h"

#import "LaunchViewController.h"
#import "MusicPlayerViewController.h"
#import "PhotoGalleryViewController.h"
#import "PhotoViewerViewController.h"
#import "SingerProfileViewController.h"
#import "MessageMainViewController.h"
#import "MessageListViewController.h"
#import "MessageThreadViewController.h"
#import "LightSticksViewController.h"
#import "VideoPlayerViewController.h"
#import "ScreensaverViewController.h"
#import "MessageReplyViewController.h"

static HGAppDelegate* appDelegateInstance = nil;

@implementation HGAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    navigationController_ = [[UINavigationController alloc] init];
    [navigationController_ setNavigationBarHidden:YES];
    self.window.rootViewController = navigationController_;

    [self setupViewTransitions];
    [self handleCommand:kInit];

    return YES;
}

+ (HGAppDelegate*)getInstance
{
    if (appDelegateInstance == nil) {
        @synchronized(self) {
            if (appDelegateInstance == nil) {
                appDelegateInstance = [[UIApplication sharedApplication] delegate];
            }
        }

    }
    return appDelegateInstance;
}

- (BOOL)handleCommand:(CommandType)command
{
    return [self handleCommandWithData:command data:nil];
}

- (BOOL)handleCommandWithData:(CommandType)command data:(id)extraData;
{
    NSDictionary *transitionTable = [transitions_ objectForKey:currentController_];

    NSString* nextViewClass = [[transitionTable objectForKey:[NSNumber numberWithInt:command]] autorelease];
    if (nextViewClass == nil) {
        return NO;
    }

    HGViewController *nextController = [[NSClassFromString(nextViewClass) alloc] init];
    [nextController setExtraData:extraData];
    [navigationController_ pushViewController:nextController animated:YES];

    return YES;
}

- (void)handleViewDidAppear:(UIViewController*)controller
{
    [currentController_ release];
    currentController_ = [NSStringFromClass([controller class]) retain];
}

- (void)handleViewDidDisappear:(UIViewController*)controller
{
}

- (void)setupViewTransitions
{
    transitions_ = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *dict;
    currentController_ = @"Init";

    // Init
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"LaunchViewController" forKey:[NSNumber numberWithInt:kInit]];
    [transitions_ setObject:dict forKey:@"Init"];

    // LaunchViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"MusicPlayerViewController" forKey:[NSNumber numberWithInt:kLaunchCountdownFinished]];
    [transitions_ setObject:dict forKey:@"LaunchViewController"];

    // MusicPlayerViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"VideoPlayerViewController" forKey:[NSNumber numberWithInt:kLaunchVideoPlayer]];
    [dict setObject:@"PhotoGalleryViewController" forKey:[NSNumber numberWithInt:kLaunchPhotoGallery]];
    [dict setObject:@"MessageMainViewController" forKey:[NSNumber numberWithInt:kLaunchMessageMain]];
    [dict setObject:@"LightSticksViewController" forKey:[NSNumber numberWithInt:kLaunchLightSticks]];
    [transitions_ setObject:dict forKey:@"MusicPlayerViewController"];

    // PhotoGalleryViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"PhotoViewerViewController" forKey:[NSNumber numberWithInt:kLaunchPhotoViewer]];
    [dict setObject:@"ScreensaverViewController" forKey:[NSNumber numberWithInt:kLaunchScreensaver]];
    [transitions_ setObject:dict forKey:@"PhotoGalleryViewController"];

    // PhotoViewerViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"SingerProfileViewController" forKey:[NSNumber numberWithInt:kLaunchSingerProfile]];
    [transitions_ setObject:dict forKey:@"PhotoViewerViewController"];

    // SingerProfileViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [transitions_ setObject:dict forKey:@"SingerProfileViewController"];

    // MessageMainViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"MessageListViewController" forKey:[NSNumber numberWithInt:kLaunchMessageList]];
    [transitions_ setObject:dict forKey:@"MessageMainViewController"];

    // MessageListViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"MessageThreadViewController" forKey:[NSNumber numberWithInt:kLaunchMessageThread]];
    [transitions_ setObject:dict forKey:@"MessageListViewController"];

    // MessageThreadViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [dict setObject:@"MessageReplyViewController" forKey:[NSNumber numberWithInt:kLaunchMessageReply]];
    [transitions_ setObject:dict forKey:@"MessageThreadViewController"];

    // LightSticksViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [transitions_ setObject:dict forKey:@"LightSticksViewController"];

    // VideoPlayerViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [transitions_ setObject:dict forKey:@"VideoPlayerViewController"];

    // ScreensaverViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [transitions_ setObject:dict forKey:@"ScreensaverViewController"];

    // MessageReplyViewController
    dict = [[[NSMutableDictionary alloc] init] autorelease];
    [transitions_ setObject:dict forKey:@"MessageReplyViewController"];

}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
