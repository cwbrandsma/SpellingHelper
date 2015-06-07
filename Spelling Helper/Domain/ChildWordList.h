//
//  ChildWordList.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Child, ChildWordHistory, WordList;

@interface ChildWordList : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * LastUpdated;
@property (nonatomic, retain) WordList * WordList;
@property (nonatomic, retain) Child * Child;
@property (nonatomic, retain) NSSet* History;

@end
