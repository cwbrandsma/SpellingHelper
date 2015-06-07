//
//  Child.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Child.h"
#import "ChildWordList.h"


@implementation Child
@dynamic Name;
@dynamic Age;
@dynamic Keyboard;
@dynamic Image;
@dynamic WordLists;

- (void)addWordListsObject:(ChildWordList *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"WordLists"] addObject:value];
    [self didChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWordListsObject:(ChildWordList *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"WordLists"] removeObject:value];
    [self didChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWordLists:(NSSet *)value {    
    [self willChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"WordLists"] unionSet:value];
    [self didChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWordLists:(NSSet *)value {
    [self willChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"WordLists"] minusSet:value];
    [self didChangeValueForKey:@"WordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
