//
//  WordsViewCell.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 9/10/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"
#import "WordList.h"

@interface WordsViewCell : AQGridViewCell {
    WordList *wordList;
    UILabel *_title;
    UIImageView * _imageView;
    NSMutableArray *_labelArray;
}

@property (nonatomic, retain) WordList *wordList;

@end
