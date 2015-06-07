//
//  FinishedView.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 9/8/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "FinishedView.h"
#import "UIColor+Hex.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Positioning.h"
#import "UIView+DefaultShadow.h"
#import "UIButton+Red.h"

@implementation FinishedView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self drawDefaultShadow];
        backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Canvas.400.jpg"]];
        backgroundView.frame = frame;
        [self addSubview:backgroundView];
        
        
        UILabel *finishLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, 50)];
        finishLabel.backgroundColor = [UIColor clearColor];
        finishLabel.textAlignment = UITextAlignmentCenter;
        finishLabel.font = [UIFont fontWithName:@"Marker Felt" size:60.0];
        finishLabel.text = @"Finished";
        [self addSubview:finishLabel];
        
        finishedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [finishedButton styleButton:[UIColor redColor]];
        finishedButton.frame = CGRectMake(0, CGRectGetMaxY(self.frame)-54, 120, 44);
        [finishedButton setTitle:@"Finish" forState:UIControlStateNormal];
        
        [finishedButton addTarget:self action:@selector(finishedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:finishedButton];
        [finishedButton centerHorizontallyInSuperView];
//        [finishedButton release];

    }
    return self;
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
    [finishedButton release];
    [super dealloc];
}

-(IBAction) finishedButtonClick: (id) sender {
    [delegate finished];
}


@end
