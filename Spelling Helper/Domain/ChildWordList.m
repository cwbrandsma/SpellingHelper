//
//  ChildWordList.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ChildWordList.h"
#import "Child.h"
#import "ChildWordHistory.h"
#import "WordList.h"


@implementation ChildWordList
@dynamic LastUpdated;
@dynamic WordList;
@dynamic Child;
@dynamic History;



- (void)addHistoryObject:(ChildWordHistory *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"History" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"History"] addObject:value];
    [self didChangeValueForKey:@"History" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeHistoryObject:(ChildWordHistory *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"History" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"History"] removeObject:value];
    [self didChangeValueForKey:@"History" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addHistory:(NSSet *)value {    
    [self willChangeValueForKey:@"History" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"History"] unionSet:value];
    [self didChangeValueForKey:@"History" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeHistory:(NSSet *)value {
    [self willChangeValueForKey:@"History" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"History"] minusSet:value];
    [self didChangeValueForKey:@"History" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
