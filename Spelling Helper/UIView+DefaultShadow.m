//
//  UIView+DefaultShadow.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 9/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UIView+DefaultShadow.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (InnerShadow)

- (void)drawDefaultShadow {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(2, 2);

}

@end
