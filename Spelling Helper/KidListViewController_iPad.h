//
//  KidListViewController_iPad.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/3/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AQGridView.h"

@interface KidListViewController_iPad : UIViewController<UITabBarDelegate, AQGridViewDelegate, AQGridViewDataSource> {
    NSManagedObjectContext *managedObjectContext;
    NSMutableArray *childList;
    UIImageView *backgroundImage;
    UIView *gridParent;
    AQGridView *gridView;
    UIView *addNewListView;
    UIView *parentViewInstructions;
}
@property (nonatomic, retain) IBOutlet UIImageView *backgroundImage;
@property (nonatomic, retain) IBOutlet UIView *gridParent;
@property (nonatomic, retain) IBOutlet AQGridView *gridView;
@property (nonatomic, retain) IBOutlet UIView *addNewListView;
@property (nonatomic, retain) IBOutlet UIView *parentViewInstructions;


-(IBAction) parentClick: (id) sender;
-(IBAction) addKidClick: (id) sender;
@end
