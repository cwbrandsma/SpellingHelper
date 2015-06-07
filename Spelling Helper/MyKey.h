//
//  MyKey.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyKeyDelegate<NSObject>

-(void) buttonClicked: (NSString *) letter;

@end



@interface MyKey : UIView {
    NSString *value;
    UIButton *btn;
    id<MyKeyDelegate> delegate;
}

@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) id<MyKeyDelegate> delegate;

@end
