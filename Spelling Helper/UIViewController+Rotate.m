//
//  UIViewController+Rotate.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 11/26/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//

#import "UIViewController+Rotate.h"
#import "Constants.h"


@implementation UIViewController (Rotate)
-(void) handlerRotate:(UIInterfaceOrientation)toInterfaceOrientation: (UIImageView *) backgroundImage{
//    return;
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {  
        UIImage *image = [UIImage imageNamed:@"Cork-Portrate.png"];
        backgroundImage.image = image;
    }
    else if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        UIImage *image = [UIImage imageNamed:@"Cork-Landscape.png"];
        backgroundImage.image = image;
    }
    else {
        UIImage *image = [UIImage imageNamed:@"Cork-Landscape.png"];
        backgroundImage.image = image;
    }
}

@end
