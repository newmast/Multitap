//
//  MenuButtonView.m
//  Multitap
//
//  Created by Nick on 2/6/16.
//  Copyright © 2016 Nick. All rights reserved.
//

#import "MenuButtonView.h"

@implementation MenuButtonView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [[self titleLabel] setFont: [[self titleLabel].font fontWithSize: 100.0]];
    }
    
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    float lineWidth = 4.0;
    
    CGContextSetLineWidth(context, lineWidth);
    CGContextSetStrokeColorWithColor(context, [GameColors getRandomColor].CGColor);
    CGContextSetFillColorWithColor(context, [GameColors getRandomColor].CGColor);
    CGRect rectange = CGRectMake(rect.origin.x + lineWidth / 2, rect.origin.y + lineWidth / 2, rect.size.width - lineWidth, rect.size.height - lineWidth);
    CGContextFillEllipseInRect(context, rect);
    CGContextAddEllipseInRect(context, rectange);
    CGContextStrokePath(context);
}

@end
