//
//  AlphabetHelper.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 6/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AlphabetHelper.h"


@implementation AlphabetHelper


+ (NSArray *) characterSetAsArrayOfCharacters:(NSMutableCharacterSet *) aset
{
    NSMutableArray *retval = [NSMutableArray array];
    const unsigned char *bitmapRep = (const unsigned char *)[[aset bitMapRepresentation] bytes];
    for (int n=0;n<8192;n++) {
        if (bitmapRep[n >> 3] & (((unsigned int)1) << (n & 7))) {
            [retval addObject:[NSString stringWithFormat:@"%C",n]];
        }
        return retval;
    }
    return nil;
}


+(NSMutableCharacterSet *) getAlphabet {
    NSMutableCharacterSet *cset = [NSMutableCharacterSet lowercaseLetterCharacterSet];
    
    return cset;
}

+(NSArray *) alphabet {
    //NSMutableCharacterSet *alpha = [self getAlphabet];
    //NSArray *list = [self characterSetAsArrayOfCharacters: alpha];
    
    NSArray *list = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil];
    return list;
}


@end
