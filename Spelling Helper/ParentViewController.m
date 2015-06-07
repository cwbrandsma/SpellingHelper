//
//  ParentViewController.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "ParentViewController.h"
#import "WordListViewController_iPad.h"
#import "Constants.h"
#import "UIViewController+Rotate.h"

@implementation ParentViewController
@synthesize backgroundImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [backgroundImage release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Parent";
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration {
    [self handlerRotate:toInterfaceOrientation :backgroundImage];    
}


-(IBAction) wordListClick {
    WordListViewController_iPad *view = [[WordListViewController_iPad alloc] initWithNibName:nil bundle:nil];
    
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}


@end
