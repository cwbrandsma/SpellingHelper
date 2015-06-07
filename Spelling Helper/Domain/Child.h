//
//  Child.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChildWordList;

@interface Child : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSNumber * Age;
@property (nonatomic, retain) NSNumber * Keyboard;
@property (nonatomic, retain) NSData * Image;
@property (nonatomic, retain) NSSet* WordLists;

- (void)addWordListsObject:(ChildWordList *)value;
- (void)removeWordListsObject:(ChildWordList *)value;

@end
