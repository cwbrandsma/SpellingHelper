//
//  WordsViewCell.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 9/10/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "WordsViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "Word.h"

@implementation WordsViewCell
@synthesize wordList;


-(void) createBackgroundLayers: (CALayer *) thelayer{
    CGFloat w = self.frame.size.width;
    
    CALayer *bg = [[CALayer alloc] init];
    bg.backgroundColor = [UIColor whiteColor].CGColor;
    bg.frame = CGRectMake(0, 0, w, 190);
    bg.shadowOffset = CGSizeMake(0, 2);
    bg.shadowOpacity = 0.80;
    
    [thelayer addSublayer:bg];
    [bg release];
    
    CALayer *top = [[CALayer alloc] init];
    top.backgroundColor = [UIColor redColor].CGColor;
    top.opacity = 0.3;
    top.frame =  CGRectMake(0, 0, w, 40);
    [thelayer addSublayer:top];
    [top release];
    
    CALayer *redLine = [[CALayer alloc] init];
    redLine.backgroundColor = [UIColor redColor].CGColor;
    redLine.frame =  CGRectMake(0, 38, w, 2);
    [thelayer addSublayer:redLine];
    [redLine release];
    
    CGFloat y = 70;
    CGFloat w2 = 30;
    for (int i = 0; i<5; i++) {
        CALayer *blueLine = [[CALayer alloc] init];
        blueLine.backgroundColor = [UIColor blueColor].CGColor;
        blueLine.opacity = 0.5;
        blueLine.frame =  CGRectMake(0, y, w, 1);
        [thelayer addSublayer:blueLine];
        [blueLine release];
        y=y+w2;
    }
    
}
- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) aReuseIdentifier {
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    if ( self == nil )
        return ( nil );
    
    _labelArray = [[[NSMutableArray alloc] init] retain];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    
    [self createBackgroundLayers: self.contentView.layer];
    
    _title = [[UILabel alloc] initWithFrame: CGRectZero];
    _title.highlightedTextColor = [UIColor blackColor];
    _title.font = [UIFont boldSystemFontOfSize: 16.0];
    _title.adjustsFontSizeToFitWidth = YES;
    _title.minimumFontSize = 10.0;
    _title.textAlignment = UITextAlignmentCenter;
    _title.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    _title.backgroundColor = self.backgroundColor;
    [self.contentView addSubview: _title];
    
	[self setSelectionStyle:AQGridViewCellSelectionStyleNone];
    
    return ( self );
}

-(void) clearLabels {
    for (UILabel *l in _labelArray) {
        [l removeFromSuperview];
    }
    [_labelArray release];
    _labelArray = [[NSMutableArray alloc] init];
}

-(void) loadWordsInList {
    // todo: sort this word list
    [self clearLabels];
    NSArray *array = [wordList.Words allObjects];
    
    int y = 10;
    int x = 10;
    
    int count = MIN([array count], 10);
    for (int i = 0; i < count; i++) {
        if (i % 2 == 0) {
            y = y + 30;
            x = 10;
        } else {
            x = 140;
        }

        Word *w = [array objectAtIndex:i];
        UILabel *l = [[UILabel alloc] init];
        l.frame = CGRectMake(x, y, 150, 30);
        l.backgroundColor = [UIColor clearColor];
        l.text = w.Word;
        [_labelArray addObject:l];
        
        [self addSubview:l];
        
    }
}

- (void) dealloc
{
    [_title release];
    [wordList release];
    [_labelArray release];
    
    [super dealloc];
}

-(void) setWordList:(WordList *)awordList {
    wordList = awordList;
    
    _title.text = wordList.Name;
    
    [self loadWordsInList];
}

@end
