//
//  WordList.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "WordList.h"
#import "ChildWordList.h"
#import "Word.h"


@implementation WordList
@dynamic Name;
@dynamic Description;
@dynamic Words;
@dynamic ChildWordLists;

- (void)addWordsObject:(Word *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Words" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Words"] addObject:value];
    [self didChangeValueForKey:@"Words" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeWordsObject:(Word *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"Words" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"Words"] removeObject:value];
    [self didChangeValueForKey:@"Words" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addWords:(NSSet *)value {    
    [self willChangeValueForKey:@"Words" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Words"] unionSet:value];
    [self didChangeValueForKey:@"Words" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeWords:(NSSet *)value {
    [self willChangeValueForKey:@"Words" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"Words"] minusSet:value];
    [self didChangeValueForKey:@"Words" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addChildWordListsObject:(ChildWordList *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"ChildWordLists"] addObject:value];
    [self didChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeChildWordListsObject:(ChildWordList *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"ChildWordLists"] removeObject:value];
    [self didChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addChildWordLists:(NSSet *)value {    
    [self willChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"ChildWordLists"] unionSet:value];
    [self didChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeChildWordLists:(NSSet *)value {
    [self willChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"ChildWordLists"] minusSet:value];
    [self didChangeValueForKey:@"ChildWordLists" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


@end
