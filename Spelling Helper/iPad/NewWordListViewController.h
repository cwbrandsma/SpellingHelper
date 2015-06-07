//
//  NewWordListViewController.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/4/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordList.h"

@protocol NewWordListDelegate <NSObject>

-(void) wordListAdded: (WordList*) wordList;

@end

@interface NewWordListViewController : UIViewController {
    UITextField *nameEdit;
    NSManagedObjectContext *managedObjectContext;
    id<NewWordListDelegate> delegate;
}

@property (nonatomic, retain) IBOutlet UITextField *nameEdit;

@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, assign) id<NewWordListDelegate> delegate;

-(IBAction) saveClick: (id) sender;

@end
