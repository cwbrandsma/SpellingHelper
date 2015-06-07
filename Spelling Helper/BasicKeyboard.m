//
//  BasicKeyboard.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/24/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "BasicKeyboard.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Hex.h"
#import "UIButton+MyKey.h"
#import "UIView+Positioning.h"

@implementation BasicKeyboard

@synthesize delegate, row1, row2, row3;

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
    [delegate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

NSInteger buttonSort(id num1, id num2, void *context)
{
    UIButton * v1 = (UIButton *)num1;
    UIButton *v2 = (UIButton *) num2;
    
    if (v1.tag < v2.tag)
        return NSOrderedAscending;
    else if (v1.tag > v2.tag)
        return NSOrderedDescending;
    else
        return NSOrderedSame;
}

-(void) centerButtonsInView: (UIView *) parentView {
    NSArray *list = [parentView subviews];
    CGRect pRect = parentView.frame;
    pRect.size.width = [list count] * 80 + 10;
    parentView.frame = pRect;
    [parentView centerHorizontallyInSuperView];
    
    NSArray *buttons = [[parentView subviews] sortedArrayUsingFunction:buttonSort context:nil];
    
    int x = 5;
    for (UIButton *b in buttons) {
        CGRect bRect = b.frame;
        bRect.origin.x = x;
        bRect.origin.y = 0;
        bRect.size.width = 75;
        bRect.size.height = 75;
        b.frame = bRect;
        x = x + 80;
    }
    
}


-(void) centerRows {
    [self centerButtonsInView: row1];
    [self centerButtonsInView: row2];
    [self centerButtonsInView: row3];
}


-(void) styleButtons {
    for (UIView *aview in [self.view subviews]) {
        for (UIButton *b in [aview subviews]) {
            [b letterStyle];
        }
    }
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self centerRows];
    [self styleButtons];
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
    
}


-(IBAction) letterClick: (id) sender {
    UIButton *btn = (UIButton *) sender;
    
    [delegate buttonClicked:btn.titleLabel.text];
}


@end
