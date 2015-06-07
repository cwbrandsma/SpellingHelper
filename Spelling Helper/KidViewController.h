//
//  KidViewController.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/18/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Child.h"
#import "AQGridView.h"
#import "KidViewTestCell.h"

@interface KidViewController : UIViewController<UIPopoverControllerDelegate, AQGridViewDelegate, AQGridViewDataSource, KidViewTestCellDelegate> {
    NSManagedObjectContext *managedObjectContext;

    Child *child;
    UILabel *childNameEdit;
    UIButton *addTestButton;
    UIView *testsRibbon;
//    UITableView *testsTable;
    NSMutableArray *wordLists;
    UIImageView *kidImage;
    UIPopoverController *popoverController;
    UIImageView *backgroundImage;
    AQGridView *aqGrid;
    UIView *cardView;

}

// Non UI Properties
@property (nonatomic, retain) Child *child;

@property (nonatomic, retain) UIPopoverController *popoverController;

// UI Properties
@property (nonatomic, retain) IBOutlet UILabel *childNameEdit;
//@property (nonatomic, retain) IBOutlet UITableView *testsTable;
@property (nonatomic, retain) IBOutlet UIImageView *kidImage;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet AQGridView *aqGrid;
@property (nonatomic, retain) IBOutlet UIButton *addTestButton;
@property (nonatomic, retain) IBOutlet UIView *cardView;
@property (nonatomic, retain) IBOutlet UIView *testsRibbon;

// Event Handlers
-(IBAction) addTest: (id) sender;

@end
