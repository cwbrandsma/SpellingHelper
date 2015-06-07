//
//  TestViewController.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChildWordList.h"
#import "AlphabetKeyboard.h"
#import "BasicKeyboard.h"
#import "TestWordViewController.h"
#import "Word.h"
#import "Child.h"
#import "TestWordView.h"
#import "FinishedView.h"
#import "FliteTTS.h"

typedef enum {
    testTypePractice,
    testTypeTest
} TestType;

@interface TestViewController : UIViewController<AlphabetKeyboardDelegate, TestWordDelegate, FinishedViewDelegate> {
    ChildWordList *childWordList;
    Child *child;
    AlphabetKeyboard *alphaKeyboard;
    BasicKeyboard *basicKeyboard;
    UIView *keyboardView;
    UIView *wordView;
    NSMutableArray *wordArray;
    UIImageView *backgroundImage;
    FinishedView *finishView;

    int position;
    NSMutableArray *letterList;
    UIView *letterParent;
    NSDate *startTime;
    
    NSMutableArray *testWordViewList;
    FliteTTS *flite;
    TestType testType;
}

@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIView *keyboardView;
@property (nonatomic, retain) IBOutlet UIView *wordView;

@property (nonatomic, retain) ChildWordList *childWordList;
@property (nonatomic, retain) Child *child;
@property (nonatomic, retain) AlphabetKeyboard *alphaKeyboard;
@property (nonatomic, retain) BasicKeyboard *basicKeyboard;

@property (nonatomic) TestType testType;

@end
