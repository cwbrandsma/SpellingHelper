//
//  TestWordView.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 9/5/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Word.h"
#import "FliteTTS.h"

@protocol TestWordDelegate<NSObject>

-(void) wordFinished: (id) owner;

@end


@interface TestWordView : UIView {
    UILabel *numberLabel;
//    UILabel *lettersLabel;
    UIButton *playSoundButton;
    Word *expectedWord;
    BOOL active;
    int letterPosition;
    
    UIView *letterParent;
    NSMutableArray *letterList;
    UIView *cardView;
    FliteTTS *flite;
    
    id<TestWordDelegate> delegate;
}

// this is the label that shows the number on the side of the word being worked on.
// value set by owner
@property (nonatomic, retain) UILabel *numberLabel;

// word being worked on
@property (nonatomic, retain) Word *expectedWord;

// Flite TTS speach engine
@property (nonatomic, retain) FliteTTS *flite;

// displays letters entered in from keyboard
//@property (nonatomic, retain) UILabel *lettersLabel;

// if active, change the display a bit and use keyboard input.
@property (nonatomic) BOOL active;

@property (nonatomic, retain) id<TestWordDelegate> delegate;

-(void) playWord: (Word *) word;
-(void) checkLetter: (NSString *) letter;


@end
