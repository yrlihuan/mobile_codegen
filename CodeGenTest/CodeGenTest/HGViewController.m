//
//  HGViewController.m
//  Copyright (c) 2011 xingxinghui.com. All rights reserved.
//

#import "HGViewController.h"

@implementation HGViewController

@synthesize extraData;
@synthesize viewDisplayed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)dealloc
{
    NSLog(@"view controller dealloc: %@", NSStringFromClass([self class]));
    [extraData release];
    [super dealloc];
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad: %@", NSStringFromClass([self class]));
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear: %@", NSStringFromClass([self class]));
    [[HGAppDelegate getInstance] handleViewDidAppear:self];
    self.viewDisplayed = true;
}

- (void)viewWillDisappear:(BOOL)animated
{
    self.viewDisplayed = false;
}

- (void)viewDidDisappear:(BOOL)animated
{
    NSLog(@"viewDidDisappear: %@", NSStringFromClass([self class]));
}

@end
