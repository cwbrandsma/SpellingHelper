//
//  AlphabetKeyboard.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "AlphabetKeyboard.h"
#import "AlphabetHelper.h"
#import "MyKey.h"
#import "UIView+Positioning.h"
#import "UIButton+MyKey.h"


@implementation AlphabetKeyboard
@synthesize alphabet, delegate;
@synthesize row1, row2, row3;

#pragma mark constants
const int rowSize = 7;
const int buttonWidth = 50;
const int buttonHeight = 50;
const int buttonSpace = 5;

#pragma mark -

-(void) clearView {
    for (UIControl *ctrl in [self.view subviews]) {
		[ctrl removeFromSuperview];
	}

}


-(void) setupStyle {
    //self.view.backgroundColor = [UIColor yellowColor];
    self.view.backgroundColor = [UIColor clearColor];
}

-(void) centerButtonsInView: (UIView *) parentView {
    NSArray *list = [parentView subviews];
    CGRect pRect = parentView.frame;
    pRect.size.width = [list count] * 80 + 10;
    parentView.frame = pRect;
    [parentView centerHorizontallyInSuperView];
    
    
    int x = 5;
    for (UIButton *b in [parentView subviews]) {
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
    for (UIButton *b in [row1 subviews]) {
        [b letterStyle];
    }
    for (UIButton *b in [row2 subviews]) {
        [b letterStyle];
    }
    for (UIButton *b in [row3 subviews]) {
        [b letterStyle];
    }
    
}


-(void) viewDidLoad {
    [super viewDidLoad];
    [self setupStyle];
    [self centerRows];
    [self styleButtons];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
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


-(void) setDelegate:(id<AlphabetKeyboardDelegate>)adelegate {
    delegate  = adelegate;
}


-(IBAction) letterClick: (id) sender {
    UIButton *btn = (UIButton *) sender;
    
    [delegate buttonClicked:btn.titleLabel.text];
}


@end
