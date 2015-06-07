//
//  TestViewController.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "TestViewController.h"
#import "AlphabetKeyboard.h"
#import "BasicKeyboard.h"
#import "ChildWordList.h"
#import "WordList.h"
#import "Word.h"
#import "ArrayHelpers.h"
#import <CoreAudio/CoreAudioTypes.h>
#import <AVFoundation/AVFoundation.h>
#import "UIView+Positioning.h"
#import "Constants.h"
#import "ChildWordHistory.h"
#import "Spelling_HelperAppDelegate.h"
#import "TestWordView.h"
#import "UIViewController+Rotate.h"

//#define testWordHeight 220
#define cardWidth 510
#define cardHeight 130


@interface TestViewController()
-(void) moveToNextWord;
-(void) testComplete;
@end

@implementation TestViewController
@synthesize childWordList, child, backgroundImage;
@synthesize alphaKeyboard, basicKeyboard, keyboardView, testType;
@synthesize wordView;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        testType = testTypeTest;
    }
    return self;
}

- (void)dealloc
{
    [letterList release];
    [wordView release];
    [childWordList release];
    [backgroundImage release];
    [alphaKeyboard release];
    [basicKeyboard release];
    [keyboardView release];
    [testWordViewList release];
    [flite release];
    
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) loadWord: (int) aposition {
    for (TestWordView *tword in testWordViewList) {
        tword.active = NO;
    }
    
    TestWordView *currentWordView = [testWordViewList objectAtIndex:aposition];
    currentWordView.active = YES;
}


-(void) moveToNextWord {
    position = position +1;
    
    if (position < [wordArray count]) {
        [self loadWord:position];
    } else {
        [self testComplete];
    }
}

-(void) setupKeyboard {
    if ([child.Keyboard intValue] == 0) {
        basicKeyboard = [[BasicKeyboard alloc] initWithNibName:nil bundle:nil];
        basicKeyboard.view.frame = self.keyboardView.bounds;
        basicKeyboard.delegate = self;
        [basicKeyboard.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self.keyboardView addSubview:basicKeyboard.view];
    } else {
        alphaKeyboard = [[AlphabetKeyboard alloc] initWithNibName:nil bundle:nil];
        alphaKeyboard.delegate = self;
        alphaKeyboard.view.frame = self.keyboardView.bounds;
        [self.keyboardView addSubview:alphaKeyboard.view];
    }
}

-(void) setupTestWordView {
    testWordViewList = [[NSMutableArray array] retain];
    
    for (int i = 0; i<wordArray.count; i++) {
        
        TestWordView *view = [[TestWordView alloc] initWithFrame:CGRectZero];
        view.flite = flite;
        view.frame = CGRectMake(30, cardHeight*i+10, cardWidth, cardHeight);
        view.expectedWord = [wordArray objectAtIndex:i];
        view.numberLabel.text = [NSString stringWithFormat:@"%d.", i+1];
        view.delegate = self;
        [wordView addSubview:view];
        [testWordViewList addObject:view];
//        [view centerHorizontallyInSuperView];
        [view release];
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupKeyboard];
    
    flite = [[[FliteTTS alloc] init] retain];
    
    WordList * wl = self.childWordList.WordList;
    NSMutableArray *a = [NSMutableArray arrayWithArray: [wl.Words allObjects]];
    wordArray = [[NSMutableArray arrayWithArray: [ArrayHelpers randomizeValueArray:a]] retain];
    [self setupTestWordView];
    
    position = 0;
    if ([wordArray count] == 0)
        [self testComplete];
    
    startTime = [NSDate date];
}

-(void) viewDidAppear:(BOOL)animated {
    [self loadWord: position];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration {
    [self handlerRotate:toInterfaceOrientation :backgroundImage];
    [letterParent centerInSuperView];
    [basicKeyboard.view centerInSuperView];
    [finishView centerInSuperView];

    return;
}

-(TestWordView *) currentWordView {
    TestWordView *atestWordView = [testWordViewList objectAtIndex:position];
    return atestWordView;
}

-(void) buttonClicked: (NSString *) letter {
    //[self checkLetter: letter];
    TestWordView *testWordView = [self currentWordView];
    [testWordView checkLetter: letter];
    
}

-(NSManagedObjectContext *) managedObjectContext {
    
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainMOC = [mainDelegate managedObjectContext]; 
    return mainMOC;
}


-(void) saveResults {
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = [mainDelegate managedObjectContext]; 

    NSString *entityName = @"ChildWordHistory";
    ChildWordHistory *hist = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:managedObjectContext];
    
    hist.ChildWordList = self.childWordList;
    hist.DateTaken = [NSDate date];
    NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate: hist.DateTaken];
    int seconds = interval;
    hist.SecondsToFinish = [NSNumber numberWithInt:seconds];

    [mainDelegate saveContext];
}

-(void) testComplete {
    [self saveResults];
    keyboardView.hidden = YES;
    
    CGRect aframe = CGRectMake(0, 0, 400, 551);
    finishView = [[FinishedView alloc] initWithFrame:aframe];
    finishView.delegate = self;
    [self.view addSubview:finishView];
    [finishView centerInSuperView];
    [finishView release];
}


#pragma mark - TestWordDelegate

-(void) wordFinished: (id) owner {
    [self moveToNextWord];
}

#pragma mark - FinishedView

-(void) finished {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
