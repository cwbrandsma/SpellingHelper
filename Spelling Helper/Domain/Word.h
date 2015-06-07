//
//  Word.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WordList;

@interface Word : NSManagedObject {
@private
}
@property (nonatomic, retain) NSData * Sound;
@property (nonatomic, retain) NSNumber * Order;
@property (nonatomic, retain) NSString * Word;
@property (nonatomic, retain) NSData * Image;
@property (nonatomic, retain) WordList * WordList;

@end
