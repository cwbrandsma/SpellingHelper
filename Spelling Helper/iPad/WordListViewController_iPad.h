//
//  WordListViewController_iPad.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"
#import "NewWordListViewController.h"

@interface WordListViewController_iPad : UIViewController <AQGridViewDataSource, AQGridViewDelegate, UIPopoverControllerDelegate, NewWordListDelegate>{
    AQGridView *wordListView;
    UIPopoverController *popoverController;
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *wordList;
    UIImageView *backgroundImage;
    UIView *addNewListView;
}

@property (nonatomic, retain) IBOutlet AQGridView *wordListView;
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIView *addNewListView;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) NSMutableArray *wordList;

-(IBAction) addButton: (id) sender;

@end
