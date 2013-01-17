//
//  HGAppDelegate.h
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kInit,
    kLaunchCountdownFinished,
    kLaunchVideoPlayer,
    kLaunchPhotoGallery,
    kLaunchMessageMain,
    kLaunchLightSticks,
    kLaunchPhotoViewer,
    kLaunchScreensaver,
    kLaunchSingerProfile,
    kLaunchMessageList,
    kLaunchMessageThread,
    kLaunchMessageReply,
} CommandType;

@interface HGAppDelegate: UIResponder <UIApplicationDelegate>
{
    UINavigationController *navigationController_;
    NSString* currentController_;
    NSMutableDictionary *transitions_;
}

@property (strong, nonatomic) UIWindow *window;

+ (HGAppDelegate*)getInstance;
- (BOOL)handleCommand:(CommandType)command;
- (BOOL)handleCommandWithData:(CommandType)command data:(id)extraData;
- (void)handleViewDidAppear:(UIViewController*)controller;
- (void)handleViewDidDisappear:(UIViewController*)controller;

- (void)setupViewTransitions;

@end

