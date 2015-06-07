//
//  AlphabetKeyboard.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyKey.h"

@protocol AlphabetKeyboardDelegate<NSObject>

-(void) buttonClicked: (NSString *) letter;

@end


@interface AlphabetKeyboard : UIViewController {
    NSArray *alphabet;
    id<AlphabetKeyboardDelegate> delegate;
    
    UIView *row1;
    UIView *row2;
    UIView *row3;
}

@property (nonatomic, retain) NSArray *alphabet;
@property (nonatomic, retain) id<AlphabetKeyboardDelegate> delegate;

@property (nonatomic, retain) IBOutlet UIView *row1;
@property (nonatomic, retain) IBOutlet UIView *row2;
@property (nonatomic, retain) IBOutlet UIView *row3;

-(IBAction) letterClick: (id) sender;

//-(void) setupAlphabet;
//-(void) setupKeyboard;

@end
