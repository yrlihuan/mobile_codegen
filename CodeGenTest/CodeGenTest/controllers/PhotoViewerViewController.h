//
//  PhotoViewerViewController.h
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGAppDelegate.h"
#import "HGViewController.h"

@interface PhotoViewerViewController : HGViewController {
}

// View Transitions Actions
- (IBAction)handleLaunchSingerProfile:(id)sender;

// Other Actions
- (IBAction)handleSavePhoto:(id)sender;
- (IBAction)handleShowButtons:(id)sender;
- (IBAction)handleHideButtons:(id)sender;
- (IBAction)handleNavigateBack:(id)sender;

@end
