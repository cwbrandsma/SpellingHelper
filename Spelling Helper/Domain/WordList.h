//
//  WordList.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChildWordList, Word;

@interface WordList : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) NSSet* Words;
@property (nonatomic, retain) NSSet* ChildWordLists;

- (void)addWordsObject:(Word *)value;
- (void)removeWordsObject:(Word *)value;
- (void)addWords:(NSSet *)value;
- (void)removeWords:(NSSet *)value;


@end
