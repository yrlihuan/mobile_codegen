//
//  MusicPlayerViewController.m
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import "MusicPlayerViewController.h"

// Define Private Methods
@interface MusicPlayerViewController()
@end

@implementation MusicPlayerViewController

// --------------------------------------
// View Lifecycle
// --------------------------------------

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (nibNameOrNil == nil) {
        [nibNameOrNil release];
        nibNameOrNil = @"YourXibFileName";
    }

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
// TODO: REMOVE THIS METHOD IF YOU'RE USING NIB FILE
- (void)loadView
{
    CGRect rect = [UIScreen mainScreen].applicationFrame;
    UIView *view = [[[UIView alloc] initWithFrame:rect] autorelease];

    UIImage *image = [UIImage imageNamed:@"music_player.png"];
    UIImageView *background = [[[UIImageView alloc] initWithImage:image] autorelease];
    [background setFrame:CGRectMake(0, 0, 320, 480)];
    [view addSubview:background];

    UILabel *text = [[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 280, 20)] autorelease];
    [text setText:NSStringFromClass([self class])];
    [view addSubview:text];

    UIButton *button = nil;

    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 25, 280, 20)];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(navigateBack:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 50, 280, 20)];
    [button setTitle:@"launch video player" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleLaunchVideoPlayer:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 75, 280, 20)];
    [button setTitle:@"launch photo gallery" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleLaunchPhotoGallery:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 100, 280, 20)];
    [button setTitle:@"launch message main" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleLaunchMessageMain:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setFrame:CGRectMake(20, 125, 280, 20)];
    [button setTitle:@"launch light sticks" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleLaunchLightSticks:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];

    view.backgroundColor = [UIColor whiteColor];

    self.view = view;
    NSLog(@"MusicPlayerViewController.loadView");
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    // Release any subviews

    [super viewDidUnload];
}

- (void)dealloc {
    // Release any variables

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// --------------------------------------
// Event Handlers
// --------------------------------------
- (IBAction)handleLaunchVideoPlayer:(id)sender
{
    [[HGAppDelegate getInstance] handleCommandWithData:kLaunchVideoPlayer data:nil];
}

- (IBAction)handleLaunchPhotoGallery:(id)sender
{
    [[HGAppDelegate getInstance] handleCommandWithData:kLaunchPhotoGallery data:nil];
}

- (IBAction)handleLaunchMessageMain:(id)sender
{
    [[HGAppDelegate getInstance] handleCommandWithData:kLaunchMessageMain data:nil];
}

- (IBAction)handleLaunchLightSticks:(id)sender
{
    [[HGAppDelegate getInstance] handleCommandWithData:kLaunchLightSticks data:nil];
}

- (IBAction)handleShowMusicList:(id)sender
{
}

- (IBAction)handleShowVideoList:(id)sender
{
}

- (IBAction)handleHideMusicList:(id)sender
{
}

- (IBAction)handleHideVideoList:(id)sender
{
}

- (IBAction)handlePlayMusic:(id)sender
{
}

- (IBAction)handlePauseMusic:(id)sender
{
}

- (IBAction)handlePlayVideo:(id)sender
{
}

- (IBAction)handleShowLyrics:(id)sender
{
}

- (IBAction)handleHideLyrics:(id)sender
{
}

- (IBAction)handleNavigateBack:(id)sender
{
}

- (IBAction)navigateBack:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

// --------------------------------------
// Private Methods
// --------------------------------------

@end
