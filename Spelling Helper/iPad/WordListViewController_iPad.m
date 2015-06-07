//
//  WordListViewController_iPad.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "WordListViewController_iPad.h"
#import "NewWordListViewController.h"
#import "Spelling_HelperAppDelegate.h"
#import "WordList.h"
#import "WordsViewController.h"
#import "Constants.h"
#import "WordsViewCell.h"
#import "UIViewController+Rotate.h"

@implementation WordListViewController_iPad

@synthesize wordListView, popoverController, wordList, backgroundImage, addNewListView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [backgroundImage release];
    [popoverController release];
    [wordListView release];
    [wordList release];
    [addNewListView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

-(void) loadNavigtionBar{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"+" 
                                  style:UIBarButtonItemStyleBordered 
                                  target:self 
                                  action:@selector(addButton:)];
	
	self.navigationItem.rightBarButtonItem = addButton;
	[addButton release];
    
    
}


-(void) loadManagedObjectContext {
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainMOC = [mainDelegate managedObjectContext]; 
    
    managedObjectContext = mainMOC;
}

-(void) loadData {
    NSManagedObjectContext *moc = managedObjectContext;
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"WordList" inManagedObjectContext:moc];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];

    
            NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                                initWithKey:@"Name" ascending:YES];
            [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            [sortDescriptor release];
    
    NSError *error;
    NSArray *array = [moc executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }
    
    
    self.wordList = [NSMutableArray arrayWithArray:array];
    [self.wordListView reloadData];
}

-(void) showLoadNewImage {
    addNewListView.hidden = self.wordList.count != 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.title = @"Word Lists";
    [self loadNavigtionBar];
    [self loadManagedObjectContext];
    [self loadData];
    [self showLoadNewImage];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.popoverController = nil;
    self.wordListView = nil;
    self.addNewListView = nil;
    self.backgroundImage = nil;
    
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


#pragma mark - AQGrid Delegate

#pragma mark - GridView Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView
{
    return [wordList count];
}

- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * CellIdentifier = @"CellIdentifier";
    
    WordsViewCell * cell = (WordsViewCell *)[gridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        cell = [[[WordsViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 300.0, 200.0) reuseIdentifier: CellIdentifier] autorelease];
    }
    
    WordList *wl = [wordList objectAtIndex:index];
    
    cell.wordList = wl;
    
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView
{
    
    return ( CGSizeMake(300.0, 200.0) );
}


-(void) editWordList: (WordList *)wl {
    WordsViewController *view = [[WordsViewController alloc] initWithNibName:nil bundle:nil];
    view.wordList = wl;
    [self.navigationController  pushViewController:view animated:YES];
    [view release];
    
}

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index {
    WordList *wl = [wordList objectAtIndex:index];
    [self editWordList:wl];
}



#pragma mark - 


-(IBAction) addButton: (id) sender {
	//create a popover controller
	if (self.popoverController == nil) {
        NewWordListViewController *popoverContent = [[NewWordListViewController alloc] autorelease];
        popoverContent.delegate = self;
        self.popoverController = [[UIPopoverController alloc] initWithContentViewController:popoverContent];
        popoverContent.popover = self.popoverController;
    }
	
    self.popoverController.delegate = self;
	[self.popoverController presentPopoverFromBarButtonItem:sender
                                   permittedArrowDirections:UIPopoverArrowDirectionUp
                                                   animated:YES];
    
}

-(void) wordListAdded: (WordList*) awordList {
    [self editWordList:awordList];

}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    [self loadData];
    [self showLoadNewImage];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController {
    return YES;
}


@end
