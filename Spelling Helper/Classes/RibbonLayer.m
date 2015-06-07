//
//  RibbonLayer.m
//  Spelling Helper
//
//  Created by Chris Brandsma on 11/26/11.
//  Copyright (c) 2011 DiamondB Software. All rights reserved.
//

#import "RibbonLayer.h"

@implementation RibbonLayer

@synthesize lineWidth, lineColor, fillColor, shaddowColor, innerLineColor;

-(void) drawGradient:(CGContextRef) theContext {
    float height = self.frame.size.height;
    float width = self.frame.size.width;

    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 1.0, 0.5, 0.4, 1.0,  // Start color
        0.8, 0.8, 0.3, 1.0 }; // End color
    
    myColorspace = CGColorSpaceCreateDeviceRGB(); 
    myGradient = CGGradientCreateWithColorComponents (myColorspace, components,
                                                      locations, num_locations);
    
    CGContextDrawLinearGradient(theContext, myGradient, CGPointMake(0, 0), CGPointMake(height, width), kCGGradientDrawsAfterEndLocation);

}

-(CGMutablePathRef) createRibbonPath:(float) top: (float) right: (float) width: (float) height: (float) half: (float) inner {

    CGMutablePathRef thePath = CGPathCreateMutable();
    CGPathMoveToPoint(thePath, NULL, right,top);
    CGPathAddLineToPoint(thePath, NULL, width, top);
    CGPathAddLineToPoint(thePath, NULL, width - inner, half);
    CGPathAddLineToPoint(thePath, NULL, width, height);
    CGPathAddLineToPoint(thePath, NULL, right, height);
    CGPathAddLineToPoint(thePath, NULL, right + inner, half);
    CGPathCloseSubpath(thePath);
    
    return thePath;
}



- (void)drawInContext:(CGContextRef)theContext
{
    float height = self.frame.size.height-4;
    float width = self.frame.size.width;
    float half = height / 2;

    float top = 0;
    float right = 0;
    float inner = 30.f;
    
    CGMutablePathRef thePath = [self createRibbonPath:top :right :width :height: half :inner];
    
    CGContextBeginPath(theContext);

    // set the gradient
    CGSize shaddowOffset = CGSizeMake(2, 2);
    CGContextSetShadowWithColor(theContext, shaddowOffset, 5, self.shaddowColor);
    
    CGContextAddPath(theContext, thePath );
    CGContextSetFillColorWithColor(theContext, self.fillColor);
    CGContextFillPath(theContext);

    CFRelease(thePath);
    
    height = height-8;
    width = width-16;
    right = right+16;
    top = top+ 8;
    half = height / 2+4;
    inner = inner - 6;
    thePath = [self createRibbonPath:top :right :width :height: half :inner];
    CGContextBeginPath(theContext);
    CGContextAddPath(theContext, thePath );
    CGContextSetShadowWithColor(theContext, CGSizeMake(0, 0), 0, self.shaddowColor);

    CGContextSetStrokeColorWithColor(theContext, self.innerLineColor);
    CGContextSetLineWidth(theContext, 2.f);
    CGContextStrokePath(theContext);
    CFRelease(thePath);
    
}


@end
