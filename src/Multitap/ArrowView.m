//
//  ArrowView.m
//  Multitap
//
//  Created by Nick on 2/7/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "ArrowView.h"

@implementation ArrowView

-(void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat originX = rect.origin.x;
    CGFloat originY = rect.origin.y;
    CGFloat height = rect.size.height;
    CGFloat width = rect.size.width;
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, originX, height / 2 - 20);
    CGContextAddLineToPoint(context, originX + width - 50, height / 2 - 20);
    CGContextAddLineToPoint(context, originX + width - 50, originY);
    CGContextAddLineToPoint(context, width, height / 2);
    CGContextAddLineToPoint(context, originX + width - 50, height / 2 + 20);
    CGContextAddLineToPoint(context, originX + width - 50, height - 20);
    CGContextAddLineToPoint(context, originX, height - 20);
    CGContextStrokePath(context);
}

@end
