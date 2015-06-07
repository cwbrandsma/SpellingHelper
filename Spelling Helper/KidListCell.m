//
//  KidListCell.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 7/19/11.
//  Copyright 2011 DiamondB Software. All rights reserved.
//

#import "KidListCell.h"
#import <QuartzCore/QuartzCore.h>


@implementation KidListCell
@synthesize child;

-(void) setChild:(Child *)achild{
    child = achild;
    NSLog(@"Loading Child: %@", child.Name);
    _title.text = child.Name;
    
    _imageView.image = [UIImage imageWithData:child.Image];
	
	[self setNeedsLayout];
}

- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) aReuseIdentifier {
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    if ( self == nil )
        return ( nil );
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = self.backgroundColor;
    self.contentView.layer.backgroundColor = [[UIColor whiteColor] CGColor];

    self.contentView.layer.shadowOffset = CGSizeMake(0, 2);
    self.contentView.layer.shadowOpacity = 0.80;

//    self.contentView.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.contentView.layer.borderWidth = 4;
//    self.contentView.layer.cornerRadius = 10;

    self.opaque = 0.5;
//    self.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.layer.cornerRadius = 10;
//    self.layer.borderWidth = 4;
//    self.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    
    _imageView = [[UIImageView alloc] initWithFrame: CGRectZero];
    _title = [[UILabel alloc] initWithFrame: CGRectZero];
    _title.highlightedTextColor = [UIColor blackColor];
//    _title.font = [UIFont boldSystemFontOfSize: 16.0];
    _title.font = [UIFont fontWithName:@"Marker Felt"  size:24.0];
    
    _title.adjustsFontSizeToFitWidth = YES;
    _title.minimumFontSize = 10.0;
    _title.backgroundColor = self.backgroundColor;
    	
    _imageView.backgroundColor = self.backgroundColor;
	
    NSString *pinName = [NSString stringWithFormat:@"redpin%d.png", (arc4random() % 5)+1];
    
    UIImageView *pinImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:pinName]];
    pinImage.frame = CGRectMake(CGRectGetMidX(frame)-32, -10, 64, 64);
    
    
    [self.contentView addSubview: _imageView];
    [self.contentView addSubview: _title];
	[self.contentView addSubview:pinImage];
    
    [pinImage release];
    
	[self setSelectionStyle:AQGridViewCellSelectionStyleNone];
	
    return ( self );
}

- (void) dealloc
{
    [_title release];
    [_imageView release];
    [child release];
    
    [super dealloc];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
//    CGSize imageSize = _imageView.image.size;
    CGRect bounds = CGRectInset( self.contentView.bounds, 5.0, 10.0 );
    
    [_title sizeToFit];
    CGRect frame = _title.frame;
    frame.size.width = MIN(frame.size.width, bounds.size.width);
    // Title position
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { // If iPad
        
        frame.origin.y = CGRectGetMaxY(bounds) - frame.size.height ;
        
    } else { // If iPhone
        
        frame.origin.y = CGRectGetMaxY(bounds) - frame.size.height - 7;
    }
    
    //frame.origin.y = floorf((bounds.size.height - frame.size.height) * 0.5)+50;
    //frame.origin.y = 100;
    frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5)+5;
    _title.frame = frame;
    
    // adjust the frame down for the image layout calculation
    bounds.size.height = frame.origin.y - bounds.origin.y;
    
    //    if ( (imageSize.width <= bounds.size.width) &&
    //        (imageSize.height <= bounds.size.height) )
    //    {
    //        return;
    //    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { // If iPad
        [_imageView sizeToFit];
        frame = _imageView.frame;
//        frame.size.width = 150;
//        frame.size.height = 150;
        //frame.size.width = floorf(imageSize.width * ratio);
        //frame.size.height = floorf(imageSize.height * ratio);
        frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5)+5;
        frame.origin.y = 20; // floorf((bounds.size.height - frame.size.height) * 0.5)+10;
        _imageView.frame = frame;
        
    } else { // If iPhone
        
        [_imageView sizeToFit];
        frame = _imageView.frame;
        frame.size.width = 73;
        frame.size.height = 45;
        // Center the image
        frame.origin.x = floorf((bounds.size.width - frame.size.width) * 0.5)+5;
        frame.origin.y = floorf((bounds.size.height - frame.size.height) * 0.5)+7;
        _imageView.frame = frame;
    }
    
    
}



@end
