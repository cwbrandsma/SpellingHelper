//
//  UIButton+UIButton_Red.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 11/26/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//

#import "UIButton+Red.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (Red)

-(void) styleButton: (UIColor*) background {
    self.backgroundColor = background; // [UIColor redColor];
    self.titleLabel.font = [UIFont fontWithName:@"Marker Felt"  size:30.0];
    self.titleLabel.shadowColor = [UIColor blackColor];
    self.titleLabel.shadowOffset = CGSizeMake(2, 2);
    self.layer.cornerRadius = 5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowOpacity = 0.5;
   
}

@end
