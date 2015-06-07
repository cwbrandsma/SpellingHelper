//
//  RibbonLayer.h
//  Spelling Helper
//
//  Created by Chris Brandsma on 11/26/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>



@interface RibbonLayer : CALayer {

    float lineWidth;
    CGColorRef lineColor;
    CGColorRef fillColor;
    CGColorRef shaddowColor;
    CGColorRef innerLineColor;
}
@property (nonatomic) float lineWidth;
@property (nonatomic) CGColorRef lineColor;
@property (nonatomic) CGColorRef fillColor;
@property (nonatomic) CGColorRef shaddowColor;
@property (nonatomic) CGColorRef innerLineColor;

@end
