//
//  KidListViewController_iPad.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "KidListViewController_iPad.h"
#import "ParentViewController.h"
#import "AddKidViewController_iPad.h"
#import "Spelling_HelperAppDelegate.h"
#import "Child.h"
#import "KidViewController.h"
#import "KidListCell.h"
#import "Constants.h"
#import "UIViewController+Rotate.h"

@implementation KidListViewController_iPad

@synthesize backgroundImage, gridParent, gridView, addNewListView, parentViewInstructions;

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
    [backgroundImage release];
    [gridParent release];
    [gridView release];
    [addNewListView release];
    [parentViewInstructions release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) loadNavigtionBar{
	UIBarButtonItem *parentButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"Parent" 
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(parentClick:)];
	
	self.navigationItem.rightBarButtonItem = parentButton;
	[parentButton release];

	
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                   initWithTitle:@"+" 
                                   style:UIBarButtonItemStyleBordered 
                                   target:self 
                                   action:@selector(addKidClick:)];
	
	self.navigationItem.leftBarButtonItem = addButton;
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
                                                  entityForName:@"Child" inManagedObjectContext:moc];
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

    childList = [[NSMutableArray arrayWithArray:array] retain];
            
}
-(void) showLoadNewImage {
    addNewListView.hidden = childList.count != 0;
    parentViewInstructions.hidden = addNewListView;
}

#pragma mark - View lifecycle

-(void) setupAQGridView {
    gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Speller List";
    [self setupAQGridView];
    [self loadNavigtionBar];
    [self loadManagedObjectContext];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
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

-(void) viewDidAppear:(BOOL)animated {
    [self loadData];
    [self.gridView reloadData];
    [self showLoadNewImage];
}

#pragma mark - View Loaders

-(void) loadParentView {
    ParentViewController *view = [[ParentViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
}

-(void) loadAddKidView {
    AddKidViewController_iPad *view = [[AddKidViewController_iPad alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:view animated:YES];
    [view release];
    
}

#pragma mark - Click Handlers

-(IBAction) parentClick: (id) sender {
    [self loadParentView];
    
}

-(IBAction) addKidClick: (id) sender {
    [self loadAddKidView];
}


#pragma mark - GridView Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView
{
    return [childList count];
}

- (AQGridViewCell *) gridView: (AQGridView *) agridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * CellIdentifier = @"KidCell";
    
    
    KidListCell * cell = (KidListCell *)[agridView dequeueReusableCellWithIdentifier: CellIdentifier];
    if ( cell == nil )
    {
        
        cell = [[[KidListCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 210, 240) reuseIdentifier: CellIdentifier] autorelease];
    }
    
    Child *kid = [childList objectAtIndex:index];
    
    cell.child = kid;
    
    
    return ( cell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) gridView
{
    return ( CGSizeMake(210.0, 240.0) );
}

- (void) gridView: (AQGridView *) gridView didSelectItemAtIndex: (NSUInteger) index {
/*    Child *wl = [self.wordLists objectAtIndex:index];
    
    TestViewController *view = [[TestViewController alloc] initWithNibName:nil bundle:nil];
    view.childWordList = wl;
    [self.navigationController pushViewController:view animated:YES];
    [view release];
  */  
    Child *aChild = [childList objectAtIndex:index];
    
    
    KidViewController *view = [[KidViewController alloc] initWithNibName:nil bundle:nil];
    view.child = aChild;
    [self.navigationController pushViewController:view animated:YES];
    [view release];

}



@end
