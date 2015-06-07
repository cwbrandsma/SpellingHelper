//
//  KidViewController.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/18/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KidViewController.h"
#import "WordList.h"
#import "ChildWordList.h"
#import "AddKidWordList.h"
#import "TestViewController.h"
#import "Spelling_HelperAppDelegate.h"
#import "KidViewTestCell.h"
#import "Constants.h"
#import "RibbonLayer.h"
#import "UIViewController+Rotate.h"

@implementation KidViewController

@synthesize child, childNameEdit, kidImage, popoverController, backgroundImage, aqGrid, addTestButton, cardView, testsRibbon;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [childNameEdit release];
    [wordLists release];
    [kidImage release];
    [popoverController release];
    [backgroundImage release];
    [aqGrid release];
    [addTestButton release];
    [testsRibbon release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void) loadManagedObjectContext {
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainMOC = [mainDelegate managedObjectContext]; 
    
    managedObjectContext = mainMOC;
}

-(void) setupAQGridView {
    aqGrid.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    aqGrid.alwaysBounceVertical = YES;
    aqGrid.layoutDirection = AQGridViewLayoutDirectionVertical;
}

-(void) setupRibbon {
    UIView *ribbonView = self.testsRibbon;
    CALayer *baseLayer = ribbonView.layer;
    
    RibbonLayer *ribbonLayer = [RibbonLayer layer];
    ribbonLayer.frame = baseLayer.bounds;
    ribbonLayer.lineColor = [UIColor redColor].CGColor;
    ribbonLayer.fillColor = [UIColor redColor].CGColor;
    ribbonLayer.shaddowColor = [UIColor blackColor].CGColor; 
    ribbonLayer.innerLineColor = [UIColor whiteColor].CGColor;
    ribbonLayer.lineWidth = 1.0;
    
    [baseLayer insertSublayer:ribbonLayer atIndex:0];
    NSLog(@"%d",[baseLayer sublayers].count);
    [ribbonLayer setNeedsDisplay];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Tests";
    
    [self setupRibbon];
    [self loadManagedObjectContext];
    
    self.cardView.layer.shadowOffset = CGSizeMake(0, 2);
    self.cardView.layer.shadowOpacity = 0.80;
    
    [self setupAQGridView];
    childNameEdit.text = child.Name;
    UIImage *image = [UIImage imageWithData:child.Image];
    kidImage.image = image;

    NSSet *testSet = self.child.WordLists;
    wordLists = [NSMutableArray arrayWithArray:[testSet allObjects]];
    [wordLists retain];

    [aqGrid reloadData];
}

-(void) viewDidAppear:(BOOL)animated {
    [aqGrid reloadData];
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
}


#pragma mark Event Handlers

-(IBAction) addTest: (id) sender {
    
    if (self.popoverController == nil) {
        AddKidWordList *popoverContent = [[AddKidWordList alloc] initWithNibName:nil bundle:nil];
        
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        popoverContent.popover = self.popoverController;
    }
	
    UIButton *btn = (UIButton*) sender;
    
    self.popoverController.popoverContentSize = CGSizeMake(200, 450);

    self.popoverController.delegate = self;
    [self.popoverController presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    

}

-(BOOL) childAlreadyHasWordList: (WordList *) wl {
    for (int i = 0; i < [wordLists count]; i++) {
        WordList * l = [wordLists objectAtIndex:i];
        if (l == wl) {
            NSIndexPath *path = [[NSIndexPath alloc] initWithIndex:i];
//            [testsTable selectRowAtIndexPath:path animated:YES scrollPosition:UITableViewScrollPositionMiddle];
            return true;
        }
    }
    return false;
}

-(ChildWordList *) createChildWordListObject: (WordList*) wl {
    NSString *entityName = @"ChildWordList";
    ChildWordList *cwl = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:managedObjectContext];
    
    cwl.WordList = wl;
    cwl.Child = self.child;
    cwl.LastUpdated = [NSDate date];
    
    return cwl;
}


- (void)popoverControllerDidDismissPopover:(UIPopoverController *)apopoverController{
    AddKidWordList * view = (AddKidWordList*)apopoverController.contentViewController;
    WordList *wl = view.selecteWordList;
    
    if (![self childAlreadyHasWordList: wl]) {
    
        ChildWordList *cwl = [self createChildWordListObject: wl];
    
        [self.child addWordListsObject:cwl];

        Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
        [mainDelegate saveContext];

        [wordLists addObject:cwl];
        [aqGrid reloadData];
    }
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}


#pragma mark - GridView Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView
{
    return [wordLists count];
}

- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * CellIdentifier = @"CellIdentifier";
    
    
    KidViewTestCell * cell = (KidViewTestCell *)[gridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[[KidViewTestCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 300.0, 200.0) reuseIdentifier: CellIdentifier] autorelease];
        cell.delegate = self;
    }
    
    ChildWordList *wl = [wordLists objectAtIndex:index];

    cell.childWordList = wl;
//    cell.timesTakenLabel.text = [NSString stringWithFormat:@"%d",[wl.History count]];

    //cell.icon = [_icons objectAtIndex: index];
    
    
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView
{
    return ( CGSizeMake(300.0, 200.0) );
}

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index {
    ChildWordList *wl = [wordLists objectAtIndex:index];
    
    TestViewController *view = [[TestViewController alloc] initWithNibName:nil bundle:nil];
    view.childWordList = wl;
    view.child = child;
    [self.navigationController pushViewController:view animated:YES];
    [view release];
    
}


#pragma mark - KidViewTestCell delegate
-(void) testCellPractice: (ChildWordList *) list {
    NSLog(@"Practice Clicked");
    TestViewController *view = [[TestViewController alloc] initWithNibName:nil bundle:nil];
    view.childWordList = list;
    view.child = child;
    [self.navigationController pushViewController:view animated:YES];
    [view release];

}
-(void) testCellTest: (ChildWordList *) list {
    NSLog(@"Test Clicked");
    TestViewController *view = [[TestViewController alloc] initWithNibName:nil bundle:nil];
    view.childWordList = list;
    view.child = child;
    [self.navigationController pushViewController:view animated:YES];
    [view release];
    
}

@end
