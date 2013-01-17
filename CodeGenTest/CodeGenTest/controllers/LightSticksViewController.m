//
//  LightSticksViewController.m
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import "LightSticksViewController.h"

// Define Private Methods
@interface LightSticksViewController()
@end

@implementation LightSticksViewController

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

    UIImage *image = [UIImage imageNamed:@"light_sticks.png"];
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

    view.backgroundColor = [UIColor whiteColor];

    self.view = view;
    NSLog(@"LightSticksViewController.loadView");
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
- (IBAction)handleShowButtons:(id)sender
{
}

- (IBAction)handleHideButtons:(id)sender
{
}

- (IBAction)handleNavigatetBack:(id)sender
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
