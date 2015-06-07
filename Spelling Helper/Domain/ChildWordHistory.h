//
//  ChildWordHistory.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChildWordList;

@interface ChildWordHistory : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDate * DateTaken;
@property (nonatomic, retain) NSNumber * SecondsToFinish;
@property (nonatomic, retain) NSString * Problems;
@property (nonatomic, retain) ChildWordList * ChildWordList;

@end
