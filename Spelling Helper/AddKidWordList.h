//
//  AddKidWordList.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/18/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordList.h"


@interface AddKidWordList : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UIPopoverController * popover;
    NSManagedObjectContext *managedObjectContext;
    UITableView *wordListTable;
    NSMutableArray *wordList;
    
    WordList *selectedWordList;
}

@property (nonatomic, retain) UIPopoverController *popover;
@property (nonatomic, retain) NSMutableArray *wordList;

@property (nonatomic, retain) IBOutlet UITableView *wordListTable;

@property (nonatomic, retain) WordList *selecteWordList;
@end
