//
//  KidViewTestCell.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/5/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"
#import "ChildWordList.h"

@protocol KidViewTestCellDelegate <NSObject>

-(void) testCellPractice: (ChildWordList *) list;
-(void) testCellTest: (ChildWordList *) list;

@end

@interface KidViewTestCell : AQGridViewCell {
    ChildWordList *childWordList;
    UILabel *_title;
    UILabel *_timesTakenLabel;
    UILabel *_dateTakenLabel;
    UILabel *_secondsTakenLabel;
    id<KidViewTestCellDelegate> delegate;
}

@property (nonatomic, retain) UILabel *timesTakenLabel;
@property (nonatomic, retain) UILabel *dateTakenLabel;
@property (nonatomic, retain) UILabel *secondsTakenLabel;
@property (nonatomic, retain) ChildWordList *childWordList;

@property (nonatomic, retain) id<KidViewTestCellDelegate> delegate;
@end
