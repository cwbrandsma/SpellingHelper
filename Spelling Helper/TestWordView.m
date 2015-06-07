//
//  TestWordView.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 9/5/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "TestWordView.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+Positioning.h"
#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVFoundation.h>

#define playSoundButtonWidth 140 
#define cardWidth 500
#define cardHeight 120


@interface TestWordView() 
-(void) setupWordLetters: (Word *) word;

@end


@implementation TestWordView

@synthesize numberLabel, expectedWord, active, delegate, flite;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        letterList = [[NSMutableArray array] retain];
        
        cardView = [[UIView alloc] initWithFrame:CGRectZero];
        cardView.frame = CGRectMake(0, 0, cardWidth, cardHeight);
        cardView.backgroundColor = [UIColor whiteColor];
        cardView.layer.shadowColor = [UIColor blackColor].CGColor;
        cardView.layer.shadowOpacity = 0.5;
        cardView.layer.shadowOffset = CGSizeMake(2, 2);
        [self addSubview:cardView];
        
        self.backgroundColor = [UIColor clearColor];
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 20, 50)];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.font = [UIFont fontWithName:@"Marker Felt"  size:24.0];

        [cardView addSubview:numberLabel];
        
        playSoundButton = [UIButton buttonWithType:UIButtonTypeCustom];
        playSoundButton.hidden = YES;
        playSoundButton.backgroundColor = [UIColor redColor];
        [playSoundButton setTitle:@"Play Word" forState:UIControlStateNormal];
        playSoundButton.titleLabel.font = [UIFont fontWithName:@"Marker Felt"  size:30.0];
        playSoundButton.titleLabel.shadowColor = [UIColor blackColor];
        playSoundButton.titleLabel.shadowOffset = CGSizeMake(2, 2);
        playSoundButton.layer.cornerRadius = 5;
        playSoundButton.layer.shadowColor = [UIColor blackColor].CGColor;
        playSoundButton.layer.shadowOffset = CGSizeMake(2, 2);
        playSoundButton.layer.shadowOpacity = 0.5;
        
        playSoundButton.frame = CGRectMake(CGRectGetMaxX(cardView.frame)-playSoundButtonWidth-6, 68, playSoundButtonWidth, 44);
        [playSoundButton addTarget:self action:@selector(playWordClick:) forControlEvents:UIControlEventTouchUpInside];
        [cardView addSubview:playSoundButton];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [numberLabel release];
    [playSoundButton release];
    [letterList release];
    [flite release];
    [expectedWord release];
    [delegate release];
    
    [super dealloc];
}

-(void) setActive:(BOOL)aActive {
    active = aActive;
    
    if (active) {
        playSoundButton.hidden = NO;
//        self.backgroundColor = [UIColor whiteColor];
        [self playWord:expectedWord];
        NSLog(@"Current Word: %@", self.expectedWord.Word);
    } else {
        playSoundButton.hidden = YES;
        self.backgroundColor = [UIColor clearColor];
    }
}

-(void) setExpectedWord:(Word *)aexpectedWord {
    expectedWord = aexpectedWord;
    
    [self setupWordLetters: aexpectedWord];
}


-(void) setupWordLetters: (Word *) word {
    
    NSString *aword = word.Word;
    
    // Make Parent View
    
    CGRect parentRect = CGRectMake(25, 0, cardView.frame.size.width - playSoundButtonWidth, cardView.frame.size.height);
    letterParent = [[UIView alloc] initWithFrame:parentRect];
    [cardView addSubview:letterParent];
    
    // draw the line under the label
    CALayer *line = [[CALayer alloc] init];
    line.frame = CGRectMake(0, 60, CGRectGetWidth(cardView.frame)-50, 2);
    line.backgroundColor = [UIColor blackColor].CGColor;
    [letterParent.layer addSublayer:line];
    [line release];

    //    [letterParent centerInSuperView];
    
    // add letter label
    int x = 0;
    for (int i=0; i< [aword length]; i++) {
        NSString *c = [aword substringWithRange:NSMakeRange(i, 1)];
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(x, -0, 40, 60)];
        l.textAlignment = UITextAlignmentLeft;
        l.backgroundColor = [UIColor clearColor];
        l.font = [UIFont fontWithName:@"Marker Felt"  size:60.0];
        l.text = c;
        l.alpha = 0.;
        
        
        [letterList addObject:l];
        
        [letterParent addSubview:l];
        x = x + 40;
    }
    parentRect.size.width = x;
    letterParent.frame = parentRect;
    
    [cardView bringSubviewToFront:playSoundButton];
//    [letterParent centerInSuperView];
    
}

-(IBAction) playWordClick: (id) sender {
    [self playWord: self.expectedWord];
}

-(void) playWord: (Word *) word {
    if (word.Sound == nil) {
        if (flite == nil)
            return;
        [flite speakText:word.Word];
    } else {
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithData:word.Sound error:nil];
        [player prepareToPlay];
        [player play];
    }
}

-(void) checkLetter: (NSString *) letter {
    
    UILabel *l = [letterList objectAtIndex:letterPosition];
    NSString *knownLetter = l.text;
    
    if ([letter isEqualToString:knownLetter]) {
        // we are good
        letterPosition = letterPosition + 1;
        l.alpha = 1.;
        
        if (letterPosition >= [letterList count]) {
            [self.delegate wordFinished:self];
        }
    } else {
        // bad letter
    }
    
}


@end
