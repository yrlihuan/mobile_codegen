//
//  PhotoGalleryViewController.h
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGAppDelegate.h"
#import "HGViewController.h"

@interface PhotoGalleryViewController : HGViewController {
}

// View Transitions Actions
- (IBAction)handleLaunchPhotoViewer:(id)sender;
- (IBAction)handleLaunchScreensaver:(id)sender;

// Other Actions
- (IBAction)handleNavigateBack:(id)sender;

@end
