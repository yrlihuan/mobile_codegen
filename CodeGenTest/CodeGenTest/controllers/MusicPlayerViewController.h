//
//  MusicPlayerViewController.h
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGAppDelegate.h"
#import "HGViewController.h"

@interface MusicPlayerViewController : HGViewController {
}

// View Transitions Actions
- (IBAction)handleLaunchVideoPlayer:(id)sender;
- (IBAction)handleLaunchPhotoGallery:(id)sender;
- (IBAction)handleLaunchMessageMain:(id)sender;
- (IBAction)handleLaunchLightSticks:(id)sender;

// Other Actions
- (IBAction)handleShowMusicList:(id)sender;
- (IBAction)handleShowVideoList:(id)sender;
- (IBAction)handleHideMusicList:(id)sender;
- (IBAction)handleHideVideoList:(id)sender;
- (IBAction)handlePlayMusic:(id)sender;
- (IBAction)handlePauseMusic:(id)sender;
- (IBAction)handlePlayVideo:(id)sender;
- (IBAction)handleShowLyrics:(id)sender;
- (IBAction)handleHideLyrics:(id)sender;
- (IBAction)handleNavigateBack:(id)sender;

@end
