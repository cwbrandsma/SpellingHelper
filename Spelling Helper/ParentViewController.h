//
//  ParentViewController.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ParentViewController : UIViewController {
    UIImageView *backgroundImage;
}

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;

-(IBAction) wordListClick;

@end
