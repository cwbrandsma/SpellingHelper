//
//  FinishedView.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 9/8/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FinishedViewDelegate<NSObject>

-(void) finished;

@end

@interface FinishedView : UIView {
    id<FinishedViewDelegate> delegate;
    UIButton *finishedButton;
    UIImageView *backgroundView;
}

@property (nonatomic, retain) id<FinishedViewDelegate> delegate;

@end
