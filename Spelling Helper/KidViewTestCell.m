//
//  KidViewTestCell.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/5/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "KidViewTestCell.h"
#import "WordList.h"
#import "ChildWordHistory.h"
#import <QuartzCore/QuartzCore.h>

@interface KidViewTestCell() 
-(IBAction)testPracticeHandler:(id)sender;
@end

@implementation KidViewTestCell
@synthesize childWordList;
@synthesize timesTakenLabel=_timesTakenLabel;
@synthesize dateTakenLabel=_dateTakenLabel;
@synthesize secondsTakenLabel=_secondsTakenLabel;
@synthesize delegate;


-(void) setChildWordList:(ChildWordList *)aChildWordList {
    childWordList = aChildWordList;
    NSString *name = childWordList.WordList.Name;
    _title.text = name;
    _timesTakenLabel.text = [NSString stringWithFormat:@"%d",[childWordList.History count]];
    
    NSArray *historyList = [childWordList.History allObjects];
    
    ChildWordHistory *hist = [historyList lastObject];
    if (hist != nil) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        
        _dateTakenLabel.text = [dateFormatter stringFromDate:hist.DateTaken];
        _secondsTakenLabel.text = [NSString stringWithFormat:@"%d", [hist.SecondsToFinish intValue]];
    }
}

-(UILabel *) createDataLabel: (CGRect) frame {
    UILabel *timesTakenTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timesTakenTextLabel.highlightedTextColor = [UIColor blackColor];
    timesTakenTextLabel.font = [UIFont boldSystemFontOfSize: 16.0];
    timesTakenTextLabel.adjustsFontSizeToFitWidth = YES;
    timesTakenTextLabel.minimumFontSize = 10.0;
    timesTakenTextLabel.textAlignment = UITextAlignmentLeft;
    timesTakenTextLabel.frame = frame;
    timesTakenTextLabel.backgroundColor = self.backgroundColor;
    
    return timesTakenTextLabel;
}

-(UILabel *) createTitleLabel: (CGRect) frame: (NSString *) text {
    UILabel *timesTakenTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timesTakenTextLabel.highlightedTextColor = [UIColor blackColor];
    timesTakenTextLabel.font = [UIFont boldSystemFontOfSize: 16.0];
    timesTakenTextLabel.adjustsFontSizeToFitWidth = YES;
    timesTakenTextLabel.minimumFontSize = 10.0;
    timesTakenTextLabel.textAlignment = UITextAlignmentLeft;
    timesTakenTextLabel.frame = frame;
    timesTakenTextLabel.backgroundColor = self.backgroundColor;
    timesTakenTextLabel.text = text;
    
    return timesTakenTextLabel;
}


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

-(void) createTitleLabel {
    _title = [[UILabel alloc] initWithFrame: CGRectZero];
    _title.highlightedTextColor = [UIColor blackColor];
    _title.font = [UIFont boldSystemFontOfSize: 16.0];
    _title.adjustsFontSizeToFitWidth = YES;
    _title.minimumFontSize = 10.0;
    _title.textAlignment = UITextAlignmentCenter;
    _title.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    _title.backgroundColor = self.backgroundColor;
    [self.contentView addSubview: _title];

}

-(void) createBottomButton: (CGRect) frame: (NSString *) title: (SEL) action {
    //NOTE: make the buttons looks like tape.
    UIButton *practice = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    practice.backgroundColor = [UIColor redColor];
    [practice setTitle:title forState:UIControlStateNormal];
    practice.titleLabel.font = [UIFont fontWithName:@"Marker Felt"  size:30.0];
    practice.titleLabel.shadowColor = [UIColor blackColor];
    practice.titleLabel.shadowOffset = CGSizeMake(2, 2);
    practice.layer.cornerRadius = 5;
    practice.layer.shadowColor = [UIColor blackColor].CGColor;
    practice.layer.shadowOffset = CGSizeMake(2, 2);
    practice.layer.shadowOpacity = 0.5;
    practice.frame = frame; // CGRectMake(5, btnY, btnWidth, btnHeight);
    [practice addTarget:self 
                 action:action 
       forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:practice];

}

-(void) createPracticeButton {
    CGFloat btnHeight = 44;
    CGFloat btnWidth = 140;
    CGFloat btnX = 5;
    CGFloat btnY = self.frame.size.height - btnHeight - 15;
    CGRect frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    [self createBottomButton:frame :@"Practice" :@selector(testPracticeHandler:)];
}
-(void) createTestButton {
    CGFloat btnHeight = 44;
    CGFloat btnWidth = 140;
    CGFloat btnX = CGRectGetMaxX(self.frame) - btnWidth - 8;    
    CGFloat btnY = self.frame.size.height - btnHeight - 15;
    CGRect frame = CGRectMake(btnX, btnY, btnWidth, btnHeight);
    [self createBottomButton:frame :@"Test" :@selector(testTestHandler:)];
}

- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) aReuseIdentifier {
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    if ( self == nil )
        return ( nil );

    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
//    self.contentView.layer.backgroundColor = [[UIColor whiteColor] CGColor];
//    self.contentView.layer.shadowOffset = CGSizeMake(0, 2);
//    self.contentView.layer.shadowOpacity = 0.80;
    
    [self createBackgroundLayers: self.contentView.layer];
    [self createTitleLabel];
    
    
    // times taken values
    UILabel *timesTakenTextLabel = [self createTitleLabel: CGRectMake(10, 40, self.frame.size.width, 30): @"Times Taken:"];
    [self.contentView addSubview:timesTakenTextLabel];
    
    _timesTakenLabel = [self createDataLabel:CGRectMake(115, 40, self.frame.size.width, 30)];
    [self.contentView addSubview: _timesTakenLabel];

    // time taken
    UILabel *dateTakenTitle = [self createTitleLabel:CGRectMake(10, 70, self.frame.size.width, 30) :@"Date Taken: "];
    [self.contentView addSubview:dateTakenTitle];
    _dateTakenLabel = [self createDataLabel:CGRectMake(30, 70, self.frame.size.width-40, 30)];
    _dateTakenLabel.textAlignment = UITextAlignmentRight;
    [self.contentView addSubview:_dateTakenLabel];
    
    
    // seconds to finish
    UILabel *secondsTakenTitle = [self createTitleLabel:CGRectMake(10, 100, self.frame.size.width, 30) :@"Seconds Taken: "];
    [self.contentView addSubview:secondsTakenTitle];
    _secondsTakenLabel = [self createDataLabel:CGRectMake(135, 100, self.frame.size.width-120, 30)];
	[self.contentView addSubview:_secondsTakenLabel];
    
    [self createPracticeButton];
    [self createTestButton];
    
	[self setSelectionStyle:AQGridViewCellSelectionStyleNone];

    return ( self );
}

- (void) dealloc
{
    [_title release];
    [childWordList release];
    [delegate release];
    
    [super dealloc];
}
- (void) layoutSubviews
{
    [super layoutSubviews];

}

-(void)drawInContext:(CGContextRef)context{
    CGRect aframe = self.contentView.frame;
    
    
    CGMutablePathRef  path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, aframe.origin.x+50, aframe.origin.y);
    CGPathAddLineToPoint(path, NULL, aframe.origin.x+50, aframe.origin.y+aframe.size.width);

    CGContextSetStrokeColorWithColor(context, [[UIColor redColor] CGColor]);
    CGContextSetLineWidth(context, 3.0);
    CGContextBeginPath(context);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
//    [self drawInContext:context];
//    CGColorRef bgColor = [UIColor redColor].CGColor;
//    CGContextSetFillColorWithColor(context, bgColor);
//    CGContextFillRect(context, layer.bounds);
    
    //static const CGPatternCallbacks callbacks = { 0, &MyDrawColoredPattern, NULL };
    
//    CGContextFillRect(context, layer.bounds);
//    CGContextRestoreGState(context);
}
-(void) drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self drawInContext:ctx];
}

-(IBAction)testPracticeHandler:(id)sender {
    [delegate testCellPractice:self.childWordList];
}

-(IBAction)testTestHandler:(id)sender {
    [delegate testCellTest:self.childWordList];
}

@end
