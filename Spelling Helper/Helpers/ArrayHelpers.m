//
//  ArrayHelpers.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/21/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "ArrayHelpers.h"


@implementation ArrayHelpers

BOOL isNextToSameNumber(NSMutableArray *array, int oldPos, int newPos) {
	int count = [array count];
	int iVal = [[array objectAtIndex:oldPos] intValue];
	int newVal = [[array objectAtIndex:newPos] intValue];
	
	
	if (newPos < count-1){
		int otherValue = [[array objectAtIndex:newPos+1] intValue];
		if (iVal == otherValue) {
			return YES;
		}
	} 
	if (newPos > 0) {
		int otherValue = [[array objectAtIndex:newPos-1] intValue];
		if (iVal == otherValue)
			return YES;
	} 
	
	
	if (oldPos < count-1){
		int otherValue = [[array objectAtIndex:oldPos+1] intValue];
		if (newVal == otherValue) {
			return YES;
		}
	} 
	if (oldPos > 0) {
		int otherValue = [[array objectAtIndex:oldPos-1] intValue];
		if (newVal == otherValue)
			return YES;
	} 
    
	return NO;
}


+(NSArray *) randomizeValueArray: (NSMutableArray *) array{
	int count = [array count];
	for (int i = count-1; i>0; i--) {
		int newPos = -1;
        newPos = arc4random() % count;
		
		[array exchangeObjectAtIndex:i withObjectAtIndex:newPos];
	}		
	return array;
}


@end
