//
//  MyKey.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "MyKey.h"


@implementation MyKey
@synthesize value, delegate;

- (id)initWithFrame:(CGRect)_frame
{
    self = [super initWithFrame:_frame];
    if (self)
    {
        btn = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        CGRect rect = CGRectMake(0, 0, _frame.size.width, _frame.size.height);
        btn.frame = rect;
//        btn.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

        [btn setTitle:@"@" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

-(void) setValue:(NSString *)avalue {
    value = avalue;
    [btn setTitle:value forState:UIControlStateNormal];
}

-(IBAction) buttonClicked: (id) sender {
    NSLog(@"Letter Clicked: %@", self.value);
   
    [delegate buttonClicked:self.value];
}

-(void)dealloc {
    [btn removeTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn release];
    [super dealloc];
}

@end
