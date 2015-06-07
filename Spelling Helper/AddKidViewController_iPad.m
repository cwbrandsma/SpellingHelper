//
//  AddKidViewController_iPad.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "AddKidViewController_iPad.h"
#import "Child.h"
#import "Spelling_HelperAppDelegate.h"
#import "Constants.h"

@implementation AddKidViewController_iPad


@synthesize nameEdit, imageEdit, popover, imageData, backgroundImage, keyboardEdit;
@synthesize takePictureButton, pickImageButton;

-(void) loadManagedObjectContext {
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *mainMOC = [mainDelegate managedObjectContext]; 

/*    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contextDidSave:) 
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:mainMOC];
  */  
    managedObjectContext = mainMOC;
}


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
    [keyboardEdit release];
    [nameEdit release];
    [imageEdit release];
    [popover release];
    [imageData release];
    [backgroundImage release];
    [takePictureButton release];
    [pickImageButton release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"Add Kid";
    [self loadManagedObjectContext];
    [nameEdit becomeFirstResponder];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        takePictureButton.hidden = YES;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [nameEdit release];
    [imageEdit release];
    [managedObjectContext release];
    [popover release];
    [imageData release];
    [takePictureButton release];
}

-(void) viewWillDisappear:(BOOL)animated {
    [popover dismissPopoverAnimated:NO];

    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation 
                                duration:(NSTimeInterval)duration {
 /*   
    if (toInterfaceOrientation == UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {  
        UIImage *image = [UIImage imageNamed:kBackground_Portrait];
        backgroundImage.image = image;
    }
    else if (toInterfaceOrientation == UIInterfaceOrientationIsLandscape(toInterfaceOrientation)){
        UIImage *image = [UIImage imageNamed:kBackground_Landscape];
        backgroundImage.image = image;
    }
    else {
        UIImage *image = [UIImage imageNamed:kBackground_Portrait];
        backgroundImage.image = image;
    }
  */
}


-(Child *) createChildObject {
    NSString *entityName = @"Child";
    Child *child = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:managedObjectContext];
    
    child.Name = nameEdit.text;
    if (imageWasSelected)
        child.Image = self.imageData;
    child.Keyboard = [NSNumber numberWithInt: keyboardEdit.selectedSegmentIndex];

    return child;
}



-(void) save {
    [self createChildObject];
    
    Spelling_HelperAppDelegate *mainDelegate = (Spelling_HelperAppDelegate *)[[UIApplication sharedApplication] delegate];
    [mainDelegate saveContext];
    return;
}


-(IBAction) addClick:(id)sender {
    [self save];    
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction) pickImageClick: (id) sender {
    imagepopover = [[UIImagePickerController alloc] init];
    imagepopover.delegate = self;
    imagepopover.sourceType =   UIImagePickerControllerSourceTypePhotoLibrary;
    imagepopover.allowsEditing = YES;
    
	UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController:imagepopover];
	aPopover.delegate = self;
	[aPopover presentPopoverFromRect: pickImageButton.frame
							 inView:sender
		   permittedArrowDirections:UIPopoverArrowDirectionAny
						   animated:YES];
	popover = aPopover;
	[imagepopover release];
}


-(IBAction) takePictureClick: (id) sender {
    imagepopover = [[UIImagePickerController alloc] init];
    imagepopover.delegate = self;
    imagepopover.sourceType =   UIImagePickerControllerSourceTypeCamera;
    imagepopover.allowsEditing = YES;

	UIPopoverController *aPopover = [[UIPopoverController alloc] initWithContentViewController:imagepopover];
	aPopover.delegate = self;
	[aPopover presentPopoverFromRect:CGRectMake(50, 50, 100, 100)
                              inView:sender
            permittedArrowDirections:UIPopoverArrowDirectionAny
                            animated:YES];
	popover = aPopover;
	[imagepopover release];
}

#pragma mark - 
#pragma mark UIImagePickerControllerDelegate


-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;{
	CGFloat hRatio = newSize.height / image.size.height;
	CGFloat height = newSize.height;
	CGFloat y = 0;
	CGFloat width = image.size.width * hRatio;
	CGFloat x = (newSize.width - width) /2;
	
	CGRect copyRect = CGRectMake(x, y, width, height);
	
	UIGraphicsBeginImageContext( newSize );
	
	[image drawInRect:copyRect];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	image = [self imageWithImage:image scaledToSize:CGSizeMake(200, 200)];
	
	imageEdit.image = image;
	
	NSData *data = [NSData dataWithData:UIImagePNGRepresentation(image)];
	self.imageData = data;
    
    imageWasSelected = YES;

	[popover dismissPopoverAnimated:YES];
	popover = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
    
    [popover dismissPopoverAnimated:YES];
	popover = nil;

}

@end
