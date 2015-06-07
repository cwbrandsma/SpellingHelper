//
//  NewWordListViewController.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/4/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "NewWordListViewController.h"
#import "WordList.h"
#import "Spelling_HelperAppDelegate.h"
#import "Constants.h"

@implementation NewWordListViewController
@synthesize nameEdit,popover, delegate;

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
    [popover release];
    [nameEdit release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) loadManagedObjectContext {
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainMOC = [mainDelegate managedObjectContext]; 
    
    managedObjectContext = mainMOC;
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameEdit.text = @"";
    self.navigationItem.title = @"Word Lists";
    self.contentSizeForViewInPopover = CGSizeMake(320.0, 160); // size of the popover
    [self loadManagedObjectContext];
    // Do any additional setup after loading the view from its nib.
    
    [nameEdit becomeFirstResponder];
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


-(WordList *) createWordListObject {
    NSString *entityName = @"WordList";
    WordList *wl = [NSEntityDescription insertNewObjectForEntityForName:entityName 
                                                 inManagedObjectContext:managedObjectContext];
    
    wl.Name = nameEdit.text;
    
    return wl;
}

-(void) save {
    
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate saveContext];    
}

-(IBAction) saveClick: (id) sender {
    WordList *wl = [self createWordListObject];
    [self save];
    [self.popover.delegate popoverControllerDidDismissPopover:self.popover];
    [self.popover dismissPopoverAnimated:YES];
    [self.delegate wordListAdded: wl];
}


@end
