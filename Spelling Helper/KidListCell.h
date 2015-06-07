//
//  KidListCell.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AQGridViewCell.h"
#import "Child.h"

@interface KidListCell : AQGridViewCell {
    Child *child;
    UILabel *_title;
    UIImageView * _imageView;

}

@property (nonatomic, retain) Child *child;

@end
