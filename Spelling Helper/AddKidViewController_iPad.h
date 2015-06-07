//
//  AddKidViewController_iPad.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddKidViewController_iPad : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>{
    UITextField *nameEdit;
    UIImageView *imageEdit;
    
    NSManagedObjectContext *managedObjectContext;
    UIImagePickerController *imagepopover;
    NSData *imageData;
    BOOL imageWasSelected;
    UIPopoverController *popover;
    UIButton *takePictureButton;
    UIButton *pickImageButton;
    UIImageView *backgroundImage;
    UISegmentedControl *keyboardEdit;
}

@property (nonatomic, retain) IBOutlet UITextField *nameEdit;
@property (nonatomic, retain) IBOutlet UIImageView *imageEdit;
@property (nonatomic, retain) IBOutlet UIButton *takePictureButton;
@property (nonatomic, retain) IBOutlet UIButton *pickImageButton;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UISegmentedControl *keyboardEdit;

@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) NSData *imageData;

-(IBAction) addClick: (id) sender;
-(IBAction) pickImageClick: (id) sender;
-(IBAction) takePictureClick: (id) sender;

@end
