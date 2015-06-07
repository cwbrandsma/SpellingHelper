//
//  UIButton+MyKey.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/27/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "UIButton+MyKey.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+Hex.h"


@implementation UIButton (UIButton_MyKey)

- (void)applyShinyBackgroundWithColor:(UIButton *) btn: (UIColor *)color {
    
    // create a CALayer 
    // to draw the gradient on
    CAGradientLayer *layer = [CAGradientLayer layer];
    
    // get the RGB components 
    // of the color
    const CGFloat *cs =
    CGColorGetComponents(color.CGColor);
    
    // create the colors for our gradient 
    // based on the color passed in
    
    layer.colors = [NSArray arrayWithObjects:
                    (id)[color CGColor],
                    (id)[[UIColor colorWithRed:0.98f*cs[0] 
                                         green:0.98f*cs[1] 
                                          blue:0.98f*cs[2] 
                                         alpha:1] CGColor],
                    (id)[[UIColor colorWithRed:0.95f*cs[0] 
                                         green:0.95f*cs[1] 
                                          blue:0.95f*cs[2] 
                                         alpha:1] CGColor],
                    (id)[[UIColor colorWithRed:0.93f*cs[0] 
                                         green:0.93f*cs[1] 
                                          blue:0.93f*cs[2] 
                                         alpha:1] CGColor],
                    nil];
    
    // create the color stops for our gradient
    layer.locations = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:0.0f],
                       [NSNumber numberWithFloat:0.49f],
                       [NSNumber numberWithFloat:0.51f],
                       [NSNumber numberWithFloat:1.0f],
                       nil];
    
    layer.frame = btn.bounds;
    layer.cornerRadius = 5;
    [btn.layer insertSublayer:layer atIndex:0];
    btn.titleLabel.font = [UIFont fontWithName:@"Marker Felt"  size:48.0];
}


-(void) letterStyle {
    CALayer *l = self.layer;
    //border
    l.cornerRadius = 5;
    l.borderColor = [[UIColor blackColor] CGColor];
    l.borderWidth = 3;
    //shadow
    l.shadowColor = [[UIColor blackColor] CGColor];
    l.shadowOffset = CGSizeMake(4.0, 4.0);
    l.shadowOpacity = 0.25;
    //        l.backgroundColor = [[UIColor redColor] CGColor];
    [self applyShinyBackgroundWithColor:self :[UIColor colorWithHex:0xA7988B]];

}

@end
